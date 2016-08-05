class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :user_course

  has_many :user_tasks, dependent: :destroy

  enum status: {pending: 0, started: 1, finished: 2}
end
