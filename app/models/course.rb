class Course
  include ActiveModel::Model
  attr_accessor :id, :name, :heading, :description, :is_published, :image_url
end
