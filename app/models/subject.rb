class Subject < ActiveRecord::Base
  has_many :course_subjects
  has_many :courses, through: :course_subjects
  has_many :user_subjects
  has_many :users, through: :user_subjects
  has_many :tasks

  validates :name, presence: true
  validates :instructions, presence: true

  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: proc {|a| a[:name].blank?}

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
