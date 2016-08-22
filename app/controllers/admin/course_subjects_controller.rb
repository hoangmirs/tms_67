class Admin::CourseSubjectsController < ApplicationController
  before_action :logged_in_user, :verify_admin_and_supervisor
  before_action :load_course_subject

  include SubjectsHelper

  def update
    session[:return_to] ||= request.referer
    if @course_subject.update_attributes course_subject_params
      flash[:success] = t "flash.success.status_update"
    else
      flash[:danger] = t "flash.danger.status_update"
    end
    redirect_to session.delete(:return_to)
  end

  private
  def course_subject_params
    params.require(:course_subject).permit :status
  end

  def load_course_subject
    @course_subject = CourseSubject.find_by id: params[:id]
    unless @course_subject
      flash[:danger] = t "admin.subjects.not_found"
      redirect_to admin_subjects_path
    end
  end
end
