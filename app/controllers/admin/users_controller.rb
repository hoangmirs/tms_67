class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.order("created_at DESC")
      .paginate page: params[:page], per_page: Settings.pagination.size
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "flash.success.create_user"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = I18n.t "users.update.update_success"
      redirect_to admin_user_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.success.destroy_user"
    else
      flash[:danger] = t "flash.danger.destroy_user"
    end
    redirect_to admin_users_path
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = I18n.t "users.not_found"
      redirect_to admin_users_path
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end
end
