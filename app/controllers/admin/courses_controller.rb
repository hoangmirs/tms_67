class Admin::CoursesController < ApplicationController

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
  def load_course
    @course = Course.find_by id: params[:id]
    unless @course
      flash[:danger] = t "courses.not_found"
      redirect_to admin_courses_path
    end
  end

  def course_params
    params.require(:course).permit :name, :instructions, :status, :start_date,
      :end_date, course_subjects_attributes: [:id, :subject_id, :course_id,
      :status, :_destroy]
  end
end
