class Course < ActiveRecord::Base
  after_create do
    self.pending!
  end

  attr_accessor :user_id

  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses

  enum status: {pending: 0, started: 1, finished: 2}

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :instructions, presence: true, length: {minimum: 10}
  validate :valid_startdate_enddate

  accepts_nested_attributes_for :course_subjects, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:subject_id].blank? ||
      attributes[:subject_id] == 0}

  accepts_nested_attributes_for :subjects, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:name].blank? &&
      attributes[:instructions].blank?}

  accepts_nested_attributes_for :user_courses, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:user_id].blank? ||
      attributes[:user_id] == 0}

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def build_course_subjects subjects_to_add = {}
    Subject.all.each do |subject|
      unless subjects_to_add.include? subject
        self.course_subjects.build subject_id: subject.id
      end
    end
  end

  def build_user_courses added_users = Array.new
    User.trainee.each do |user|
      unless added_users.include? user
        self.user_courses.build user_id: user.id
      end
    end
  end

  private
  def valid_startdate_enddate
    return if [end_date.blank?, start_date.blank?].any?
    if start_date > end_date
      errors.add :base, I18n.t("admin.error_messages.start_after_end")
    end
  end
end
