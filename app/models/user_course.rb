class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  scope :by_user, ->user{where user_id: user.id}
end
