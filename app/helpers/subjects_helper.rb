module SubjectsHelper
  def get_user_subject subject
    current_user.user_subjects.find_by subject_id: subject.id
  end

  def get_subject_status subject
    user_subject = get_user_subject subject
    user_subject.status if user_subject
  end
end
