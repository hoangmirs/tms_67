class SessionsController < ApplicationController
  def new
    redirect_to root_url if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      flash[:success] = I18n.t "flash.success.login"
      log_in user
      params[:session][:remember_me] == Settings.session.remember_value ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = I18n.t "sessions.create.login_invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
