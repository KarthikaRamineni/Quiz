class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password]) and user.id == 6 and !session[:user_id]
      session[:user_id] = user.id
      redirect_to admin_index_url
    elsif user and user.authenticate(params[:password]) and !session[:user_id]
      session[:user_id] = user.id
      redirect_to player_index_url
    else
      redirect_to login_url, alert:"Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, alert:"Successfully logged out"
  end
end
