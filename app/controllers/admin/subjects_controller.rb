class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user, :verify_admin

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "flash.success.create_subject"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :instructions,
      tasks_attributes: [:id, :name, :_destroy]
  end
end
