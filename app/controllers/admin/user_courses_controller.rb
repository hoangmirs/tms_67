class Admin::UserCoursesController < ApplicationController
  before_action :load_course, only: [:show, :update]

  def show
    @users = User.order "created_at DESC"
    @course.build_user_courses @course.users
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "flash.success.add_user_to_course"
      redirect_to admin_course_path @course.users
    else
      render :edit
    end
  end

  private
  def load_course
    @course = Course.find_by id: params[:course_id]
    unless @course
      flash[:danger] = t "courses.not_found"
      redirect_to admin_courses_path
    end
  end

  def course_params
    params.require(:course).permit user_courses_attributes: [:id, :course_id, :user_id, :_destroy]
  end
end
