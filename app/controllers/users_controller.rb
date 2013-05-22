class UsersController < ApplicationController
  before_filter :require_login, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    user_details_from_form = params[:user]
    @user = User.create(user_details_from_form.merge(session[:user_info]))
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
      UserMailer.signup_confirmation(@user).deliver
    else
      redirect_to root_url(:subdomain => false), notice: "Login failed"
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def show
    @user = current_user
    @feeds = @user.feeds
  end
end
