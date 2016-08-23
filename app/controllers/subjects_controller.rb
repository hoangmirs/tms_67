class SubjectsController < ApplicationController
  before_action :load_subject, only: [:show, :update]

  include SubjectsHelper

  def show
    @tasks = @subject.tasks
    @activities = current_user.activities
      .by_target Settings.activity.target_type.subject, @subject.id
    @user_tasks = Task.by_user current_user
    @user_subject.build_user_tasks current_user, @user_tasks
  end

  def update
    session[:return_to] ||= request.referer
    if @user_subject.update_attributes user_subject_params
      flash[:success] = t "flash.success.report_updated"
      redirect_to session.delete(:return_to)
    else
      flash[:danger] = t "flash.danger.report_updated"
      redirect_to courses_path
    end
  end

  private
  def load_subject
    @subject = Subject.find_by id: params[:id]
    @course = Course.find_by id: params[:course_id]
    unless @subject && current_user.subjects.include?(@subject) && @course
      flash[:danger] = t ".not_found"
      redirect_to courses_path
    end
    @user_subject = get_user_subject current_user, @subject, @course.id
  end

  def user_subject_params
    params.require(:user_subject).permit :status,
      user_tasks_attributes: [:user_id, :task_id]
  end
end
