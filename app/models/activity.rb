class Activity < ActiveRecord::Base
  belongs_to :user

  scope :by_target, ->target_type, target_id do
    where(target_type: target_type, target_id: target_id)
      .order created_at: :desc
  end
end
