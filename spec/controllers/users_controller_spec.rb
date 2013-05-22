require 'spec_helper'

describe UsersController do

  describe 'users#NEW' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'users#CREATE' do
    before do
      @omniauth_hash = {
      'provider' => 'twitter',
      'uid' => '123545',
      'info' => {
        'nickname' => 'mockuser',
        'image' => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }
  end

    it 'creates a new user with the provided email and user info stored in session' do
      expect{
        post :create, {user: {email: 'user@example.com'}}, {user_info: {username: 'mockuser', provider: 'twitter', provider_id: '123545'}}
      }.to change{User.count}.by(1)

      created_user = User.last
      expect(created_user.username).to eq ('mockuser')
      expect(created_user.provider).to eq ('twitter')
      expect(created_user.provider_id).to eq ('123545')
    end

    it 'redirects the user back to the dashboard' do
      post :create, {user: {email: 'user@example.com'}}, {user_info: {username: 'mockuser', provider: 'twitter', provider_id: '123545'}}
      expect(response).to redirect_to dashboard_path
    end

    it 'sets the user id in the session to log them in' do
      post :create, {user: {email: 'user@example.com'}}, {user_info: {username: 'mockuser', provider: 'twitter', provider_id: '123545'}}

      expect(session[:user_id]).to eq User.last.id
    end

    it 'does something when the create fails'
  end

  describe 'users#SHOW' do
    context 'when a user is logged in' do
      it 'assigns the user' do
        user = User.create(email: 'user@example.com', username: 'coolness')
        controller.stub(:require_login).and_return(true)
        controller.stub(:current_user).and_return(user)
        get :show
        expect(assigns(user)).to eq @user
      end

      it 'renders the show template' do
        user = User.create(email: 'user@example.com', username: 'coolness')
        controller.stub(:require_login).and_return(true)
        controller.stub(:current_user).and_return(user)
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
