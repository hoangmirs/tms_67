class CourseSubject < ActiveRecord::Base
  attr_accessor :user_id

  belongs_to :course
  belongs_to :subject

  after_create do
    self.pending!
  end

  after_update do
    if self.status_changed?
      if self.started?
        create_user_subjects
      elsif self.finished?
        update_user_subjects
      end
    end
  end

  enum status: {pending: 0, started: 1, finished: 2}

  private
  def create_user_subjects
    course.user_courses.each do |user_course|
      user_course.user_subjects.create user_id: user_course.user.id,
        subject_id: subject.id,
        status: status, start_date: course.start_date,
        end_date: course.end_date
    end
  end

  def update_user_subjects
    course.user_courses.each do |user_course|
      user_course.user_subjects.each do |user_subject|
        user_subject.update status: status
      end
    end
  end
end
