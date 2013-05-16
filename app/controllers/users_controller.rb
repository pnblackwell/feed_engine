class UsersController < ApplicationController

  def new
    @user = User.new(username: params[:xyz])
  end

  def edit
    @user = User.from_omniauth(env['omniauth.auth'])
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
      UserMailer.signup_confirmation(@user).deliver
    else
      redirect_to root_path
    end
  end

end
