class User < ActiveRecord::Base
  attr_accessor :remember_token

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

  def active_course
    user_course = user_courses.find &:is_active?
    user_course.try :course
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  class << self
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |user|
          csv << user.attributes.values_at(*column_names)
        end
      end
    end
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def remember
    remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

end
