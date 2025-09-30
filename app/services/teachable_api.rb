# frozen_string_literal: true

# Teachable API Client
# Requires the 'httparty' gem
module TeachableApi
  include HTTParty
  base_uri "https://developers.teachable.com"

  # Fetch all courses at your school
  def self.get_courses
    get("/v1/courses", http_headers)
  end

  # Fetch active enrolled students and student progress for a specific course
  def self.get_enrollments(course_id)
    get("/v1/courses/#{course_id}/enrollments", http_headers)
  end

  # List a specific user and their course enrollments by user ID
  def self.get_user(user_id)
    get("/v1/users/#{user_id}", http_headers)
  end

  private

  def self.http_headers
    { headers: { "apiKey" => Rails.application.credentials.teachable.api_key } }
  end
end
