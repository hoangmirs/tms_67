class Activity < ActiveRecord::Base
  belongs_to :user

  scope :by_target, ->target_type, target_id do
    where(target_type: target_type, target_id: target_id)
      .order created_at: :desc
  end

  scope :by_user, -> user_id do
    where(user_id: user_id)
      .order created_at: :desc
  end

  def name
    case target_id
    when Settings.activity.target_type.course
      Course.find_by(id: target_id)&.name
    when Settings.activity.target_type.subject
      Subject.find_by(id: target_id)&.name
    when Settings.activity.target_type.task
      Task.find_by(id: target_id)&.name
    else
      nil
    end
  end
end
