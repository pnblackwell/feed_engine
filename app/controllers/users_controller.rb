class UsersController < ApplicationController

  def new
    @user = User.new(username: params[:xyz])
  end

  def edit
    # if user.email?
      #show existing user form
    # else
      #show the single email form
    # end
    @user = User.from_omniauth(env['omniauth.auth'])
      
  end

  def create
    user = User.create(params[:user])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def update
    @user = User.from_omniauth(env['omniauth.auth'])
    user.update_attribute(:email, )
    # if they entered email and saved to the db
    # then set the session hash session[:user_id] = @user.id
    redirect_to root_path
  end

end