class User < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :user_subjects
  has_many :subjects, through: :user_subjects
  has_many :user_tasks
  has_many :tasks, through: :user_tasks

  enum role: {trainee: 0, supervisor: 1, admin: 2}

  validates :name,  presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
end
