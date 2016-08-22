class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  after_create :create_user_subjects

  scope :by_user, ->user{where user_id: user.id}

  private
  def create_user_subjects
    if course.subjects.present?
      course.subjects.each do |subject|
        user_subjects.create user: user, subject: subject,
          status: Settings.status.pending, start_date: course.start_date,
          end_date: course.end_date
      end
    end
  end
end
