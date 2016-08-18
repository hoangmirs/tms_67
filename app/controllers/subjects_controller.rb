class SubjectsController < ApplicationController
  before_action :load_subject, only: :show

  def show
    @tasks = @subject.tasks
    @activities = current_user.activities
      .by_target Settings.activity.target_type.subject, @subject.id
  end

  private
  def load_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject && current_user.subjects.include?(@subject)
      flash[:danger] = t ".not_found"
      redirect_to courses_path
    end
  end
end
