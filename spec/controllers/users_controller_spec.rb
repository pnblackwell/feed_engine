require 'spec_helper'

describe UsersController do
  
  describe 'users#NEW' do

    it 'populates an @user with a new user that has a nickname' do
      get :new, xyz: 'mockuser'

      expect(assigns(:user).username).to eq('mockuser')
    end

    it 'renders the new template' do
      get :new, xyz: 'mockuser'
      expect(response).to render_template(:new)
    end
  end

  describe 'users#CREATE' do
    it 'creates a new user with the provided email and username' do
      expect{post :create, user: {email: 'user@example.com', username: 'coolness'}}.to change{User.count}.by(1)
    end

    it 'redirects the user back to the homepage' do
      post :create, user: {email: 'user@example.com', username: 'coolness'}

      expect(response).to redirect_to root_path
    end

    it 'sets the user id in the session to log them in' do
      post :create, user: {email: 'user@example.com', username: 'coolness'}

      expect(session[:user_id]).to eq User.last.id
    end

    it 'does something when the create fails'
  end

  describe 'users#SHOW' do
    context 'when a user is logged in' do
      it 'assigns the user' do
        user = User.create(email: 'user@example.com', username: 'coolness')
        controller.stub(:require_login).and_return(true)
        get :show
        expect(assigns(:user)).to eq @user
      end

      it 'renders the show template' do
        user = User.create(email: 'user@example.com', username: 'coolness')
        controller.stub(:require_login).and_return(true)
        get :show
        expect(response).to render_template(:show)
      end
    end

    context 'when a user is NOT logged in' do
      it 'redirects the user to the home page' do
        get :show
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
