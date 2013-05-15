require 'spec_helper'

describe 'user dashboard' do

  def log_in_user
    User.create(username: 'mockuser')
    visit root_path
    mock_auth_hash # OmniauthMockHelper.mock_auth_hash
    click_link "Sign in with twitter"
  end

  describe 'viewing the dashboard' do
    it 'provides a button to create a new feed' do
      log_in_user
      visit '/dashboard'
      expect(page).to have_content('Create A New Feed')
    end
  end

  describe 'creating a new feed' do
    context 'when the user fills in the form' do
      it 'creates a new feed and redirects to its show page' do
        pending 'we are currently doing this in create new feed spec'
        # log_in_user
        # visit '/dashboard'
        # click_link_or_button 'Create A New Feed'
        # fill_in :name, with: ''
      end
    end
  end
end
