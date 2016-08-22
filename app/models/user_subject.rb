class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :user_course

  has_many :user_tasks, dependent: :destroy

  enum status: {pending: 0, started: 1, finished: 2}

  accepts_nested_attributes_for :user_tasks, allow_destroy: true,
    reject_if: proc {|attributes| attributes[:user_id].blank? ||
      attributes[:task_id].blank?}

  scope :by_user, ->user{where user_id: user.id}
  scope :by_subject, ->subject{where subject_id: subject.id}
  scope :by_course_subject, ->course_id, subject do
    user_course_ids = "SELECT id FROM user_courses WHERE  course_id = :course_id"
    where("user_course_id IN (#{user_course_ids})", course_id: course_id)
      .by_subject subject
  end

  def build_user_tasks user, finished_tasks = Array.new
    self.subject.tasks.each do |task|
      unless finished_tasks.include? task
        self.user_tasks.build user_id: user.id, task_id: task.id
      end
    end
  end
end
