class Task < ActiveRecord::Base
  belongs_to :subject

  has_many :user_tasks
  has_many :users, through: :user_tasks

  scope :by_user, ->user do
    task_ids = "SELECT task_id FROM user_tasks WHERE  user_id = :user_id"
    where("id IN (#{task_ids})", user_id: user.id)
  end
end
