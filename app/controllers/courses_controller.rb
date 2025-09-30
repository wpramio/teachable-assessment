require_relative "../services/teachable_api"

class CoursesController < ApplicationController
  # GET /courses
  def index
    @courses = Rails.cache.fetch("courses_list", expires_in: 30.minutes) do
      TeachableApi.get_courses.map do |course_data|
        Course.new(
          id: course_data["id"].to_i,
          name: course_data["name"],
          heading: course_data["heading"],
          description: course_data["description"],
          is_published: course_data["is_published"],
          image_url: course_data["image_url"]
        )
      end
    end
  end

  # GET /courses/1/enrollments
  def enrollments
    courses_list = Rails.cache.read("courses_list") || []
    @course = courses_list.find { |course| course.id == params[:id].to_i }

    render plain: "Not found", status: :not_found and return unless @course

    @enrollments = Rails.cache.fetch("enrollments_course_#{@course.id}", expires_in: 30.minutes) do
      enrollments_data = TeachableApi.get_enrollments(@course.id)
      # with parallel threads to speed up user data fetching
      threads = []
      enrollments_data.each do |enrollment_data|
        threads << Thread.new do
          user_data = TeachableApi.get_user(enrollment_data["user_id"])
          Enrollment.new(
            enrolled_at: enrollment_data["enrolled_at"],
            expires_at: enrollment_data["expires_at"],
            completed_at: enrollment_data["completed_at"],
            percent_complete: enrollment_data["percent_complete"].to_f,
            user_id: enrollment_data["user_id"].to_i,
            user_name: user_data["name"],
            user_email: user_data["email"]
          )
        end
      end

      threads.map(&:value)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.fetch(:course, {})
    end
end
