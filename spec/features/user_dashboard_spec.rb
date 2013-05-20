require 'spec_helper'

describe 'user dashboard' do

  def log_in_user
    User.create(username: 'mockuser')
    visit root_path
    mock_auth_hash # OmniauthMockHelper.mock_auth_hash
    click_link_or_button "signin"
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
        log_in_user
        visit '/dashboard'
        save_and_open_page
        click_link_or_button 'Create A New Feed'

        fill_in "feed_name", with: "Jen's Pics"
        fill_in "feed_subdomain", with: "jenspics"
        fill_in "value", with: "white raven photography"
        click_link_or_button "Create Feed"

        expect(page).to have_selector('img')
      end
    end
  end
end
