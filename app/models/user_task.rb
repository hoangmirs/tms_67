class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :user_subject

  after_create :create_task_activity

  scope :by_user, ->user_id{where user_id: user_id}

  private
  def create_task_activity
    content = Settings.activity.content.completed_task + " " + task.name
    user.activities.create target_type: Settings.activity.target_type.subject,
      target_id: user_subject.subject.id, content: content
  end
end
