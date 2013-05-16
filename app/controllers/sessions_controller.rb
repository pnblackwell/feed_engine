class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to new_feed_path, notice: 'Signed In!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed Out!'
  end

  def home

  end
end