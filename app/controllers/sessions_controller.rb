class SessionsController < ApplicationController

  def create
    twitter_nickname = request.env['omniauth.auth']['info']['nickname']
    user = User.where(:username => twitter_nickname).first

    if user.present?
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      session[:omniauth_results] = request.env['omniauth.auth']
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed Out!'
  end

  def home
    redirect_to dashboard_path if current_user
  end
end



