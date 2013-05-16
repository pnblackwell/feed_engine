require 'spec_helper'

describe SessionsController do
  describe 'sessions#create' do
    describe 'when user exists matched by username' do
      it 'logs the user in' do
        found_user = User.create(username: 'mockuser')

        mock_auth_hash
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

        get :create

        expect(session[:user_id]).to eq(found_user.id)
      end
      it 'redirects to the root path' do
        found_user = User.create(username: 'mockuser')

        mock_auth_hash
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

        get :create        
        expect(response).to redirect_to root_path
      end
    end

    describe 'when user does not exist' do
      it 'should redirect to the users#new with the username as a query parameter' do
        mock_auth_hash
        request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]

        get :create

        expect(response).to redirect_to new_user_path(xyz: 'mockuser')
      end
    end
  end
  
end
