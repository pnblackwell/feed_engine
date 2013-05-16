class UsersController < ApplicationController
  before_filter :require_login, only: [:show, :edit, :update]

  def new
    @user = User.new(username: params[:xyz])
  end

  def edit
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
    redirect_to dashboard_path
  end

  def show
    @user = current_user
    @feed = Feed.new
    @feed.searches.new
  end
end
