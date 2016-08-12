class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_subject, except: [:index, :new, :create]

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
    @subject.tasks.build
  end

  def show
    @tasks = @subject.tasks
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

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "flash.success.update_subject"
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "flash.success.delete_subject"
    else
      flash[:error] = t "flash.error.delete_subject"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :instructions,
      tasks_attributes: [:id, :name, :_destroy]
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    unless @subject
      flash[:danger] = t "admin.subjects.not_found"
      redirect_to admin_subjects_path
    end
  end
end
