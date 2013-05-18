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
        post :create, {user: {email: 'user@example.com'}}, {omniauth_results: @omniauth_hash}
      }.to change{User.count}.by(1)

      created_user = User.last
      expect(created_user.username).to eq ('mockuser')
      expect(created_user.provider).to eq ('twitter')
      expect(created_user.provider_id).to eq ('123545')
    end

    it 'redirects the user back to the homepage' do
      post :create, {user: {email: 'user@example.com'}}, {omniauth_results: @omniauth_hash}

      expect(response).to redirect_to root_path
    end

    it 'sets the user id in the session to log them in' do
      post :create, {user: {email: 'user@example.com'}}, {omniauth_results: @omniauth_hash}

      expect(session[:user_id]).to eq User.last.id
    end

    it 'does something when the create fails'
  end
end
