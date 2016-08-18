class CoursesController < ApplicationController
  before_action :load_course, only: :show

  def index
    @courses = current_user.courses
  end

  def show
    @subjects = @course.subjects
    @activities = current_user.activities
      .by_target Settings.activity.target_type.course, @course.id
  end

  private
  def load_course
    @course = Course.find_by id: params[:id]
    unless @course && current_user.courses.include?(@course)
      flash[:danger] = t "courses.course.not_found"
      redirect_to courses_path
    end
  end
end
