class SessionsController < ApplicationController
  
  before_filter :require_login, :only => :destroy
  before_filter :authenticate_user, :only => [:new, :create]
  
  def new
  end
  
  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Logged in!"
    else
      flash[:error] = "LoginId or password was invalid"
      redirect_to login_path
    end
  end
  
  def destroy
    logout
    redirect_to login_path, :notice => "Logged out!"
  end
  
  private
  def authenticate_user
    flash[:notice] = "You are already logged in." and redirect_to "/" and return if current_user.present?
  end
end
