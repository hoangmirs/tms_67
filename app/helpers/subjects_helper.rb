module SubjectsHelper
  def get_user_subject user, subject, course_id
    user.user_subjects.by_course_subject(course_id, subject).first
  end
end
