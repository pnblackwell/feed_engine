class SessionsController < ApplicationController

  def create
    # user = User.from_omniauth(env['omniauth.auth'])
    # if user.email?
    #   session[:user_id] = user.id
    #   redirect_to root_url, notice: 'Signed In!'
    # else
    #   redirect_to user_edit_path(user)
    # end
    twitter_nickname = request.env['omniauth.auth']['info']['nickname']
    user = User.where(:username => twitter_nickname).first

    if user.present?
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_user_path(:xyz => twitter_nickname)
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Signed Out!'
  end
end