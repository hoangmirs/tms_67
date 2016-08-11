class CourseSubject < ActiveRecord::Base
  attr_accessor :user_id

  belongs_to :course
  belongs_to :subject
end
