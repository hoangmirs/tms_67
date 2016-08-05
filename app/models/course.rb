class Course < ActiveRecord::Base
  has_many :course_subjects
  has_many :subjects, through: :course_subjects
  has_many :user_courses
  has_many :users, through: :user_courses

  enum status: {pending: 0, started: 1, finished: 2}
end
