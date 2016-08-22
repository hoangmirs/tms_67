class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  scope :by_user, ->user_id{where user_id: user_id}
end
