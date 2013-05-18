class UsersController < ApplicationController
  before_filter :require_login, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.from_omniauth(env['omniauth.auth'])
  end

  def create
    user_details_from_form = params[:user]
    user_details_from_omniauth = omniauth_user_info(session[:omniauth_results])

    @user = User.create(user_details_from_form.merge(user_details_from_omniauth))
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      UserMailer.signup_confirmation(@user).deliver
    else
      redirect_to root_path, notice: "Login failed"
    end
  end

  def show
    @user = current_user
    @feed = Feed.new
    @feed.searches.new
  end

private

  def omniauth_user_info(omniauth_details)
    username = omniauth_details['info']['nickname']
    provider = omniauth_details['provider']
    provider_id = omniauth_details['uid']

    {username: username, provider: provider, provider_id: provider_id}
  end
end
