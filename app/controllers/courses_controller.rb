require_relative "../services/teachable_api"

class CoursesController < ApplicationController
  # GET /courses
  def index
    @courses = Rails.cache.fetch("courses_list", expires_in: 5.minutes) do
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

  # GET /courses/1
  def show
    courses_list = Rails.cache.read("courses_list") || []
    @course = courses_list.find { |course| course.id == params[:id].to_i }

    render plain: "Not found", status: :not_found and return unless @course
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
