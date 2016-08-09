class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :load_user, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.update.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    flash[:success] = t "users.not_found"
    redirect_to root_url unless @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end
end
