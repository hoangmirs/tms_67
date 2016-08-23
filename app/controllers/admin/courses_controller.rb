class Admin::CoursesController < ApplicationController
  before_action :logged_in_user, :verify_admin_and_supervisor
  before_action :load_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.pagination.size
  end

  def new
    @course = Course.new
    @course.build_course_subjects
  end

  def create
    @course = Course.new course_params
    @course.user_id = current_user.id
    if @course.save
      flash[:success] = t "admin.flash.create_course"
      redirect_to admin_course_path @course
    else
      @course.build_course_subjects
      render :new
    end
  end

  def update
    @course = Course.find_by id: params[:id]
    prevent_course_nil

    respond_to do |format|
      if @course.update_attributes course_params
        format.json do
          render json: {
            course_id: @course.id,
            course_path: admin_course_path(@course),
            course_status: @course.status,
            button_text: get_button_text,
            confirm_text: t("admin.courses.course_item.confirm_finish")
          }
        end
        format.html do
          flash[:success] = t "admin.flash.edit_course"
          redirect_to admin_course_path @course
        end
      else
        format.html do
          flash[:danger] = t "admin.error_messages.error_occurred"
          render :edit
        end
      end
    end
  end

  def edit
    @course = Course.find_by id: params[:id]
    prevent_course_nil

    unless @course.nil?
      @course.build_course_subjects @course.subjects
    end
  end

  def show
  end

  def destroy
    @course = Course.find_by id: params[:id]

    if @course.present? && @course.destroy
      flash[:success] = t "admin.courses.mess_delete_success"
    else
      flash[:warning] = t "admin.courses.mess_delete_fail"
    end

    redirect_to admin_courses_path
  end

  private
  def course_params
    params.require(:course).permit :name, :instructions, :status, :start_date,
      :end_date, course_subjects_attributes: [:id, :subject_id, :course_id,
      :status, :_destroy]
  end

  def prevent_course_nil
    if @course.nil?
      flash[:error] = t "admin.error_messages.error_occurred"
      redirect_to admin_courses_path
    end
  end

  def get_button_text
    case @course.status
    when Settings.status.started_text
      t("admin.courses.course_item.finish_course")
    when Settings.status.finished_text
      t("admin.courses.course_item.inactive_course")
    end
  end

  def load_course
    @course = Course.find_by id: params[:id]
    unless @course
      flash[:course] = t "courses.not_found"
      redirect_to admin_courses_path
    end
  end
end
