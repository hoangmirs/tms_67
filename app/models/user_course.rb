class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  after_create :set_active, :create_user_course_activity

  scope :by_user, ->user{where user_id: user.id}

  private
  def set_active
    UserCourse.where(user_id: user_id).each do |user_course|
      user_course.update is_active: Settings.status.inactive
    end
    self.update is_active: Settings.status.active
  end

  def create_user_course_activity
    content = Settings.activity.content.joined_course
    user.activities.create target_type: Settings.activity.target_type.course,
      target_id: course.id, content: content
  end
end
