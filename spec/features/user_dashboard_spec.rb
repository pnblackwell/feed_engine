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
    context 'when the user searches for a valid flickr screen name' do
      it 'creates a new feed and redirects to its show page' do
        log_in_user
        visit '/dashboard'
        click_link_or_button 'Create A New Feed'

        fill_in "feed_name", with: "Jen's Pics"
        fill_in "feed_subdomain", with: "jenspics"
        fill_in "value", with: "white raven photography"
        check "flickr"
        choose "Screen Name"
        click_link_or_button "Create Feed"

        expect(page).to have_selector('img')
      end
    end

    context 'when the user searches for an ivalid flickr screen name' do
      it 'does something' do
        #same for 500px
      end
    end

    context 'when the user searches for a flickr keyword' do
      it 'creates a new feed and redirects to its show page' do
        log_in_user
        visit '/dashboard'
        click_link_or_button 'Create A New Feed'

        fill_in "feed_name", with: "dogs"
        fill_in "feed_subdomain", with: "dogs"
        fill_in "value", with: "dogs"
        check "flickr"
        choose "Keyword"
        click_link_or_button "Create Feed"

        expect(page).to have_selector('img')
      end
    end

    context 'when the user searches for a valid 500px screen name' do
      it 'creates a new feed and redirects to its show page' do
        log_in_user
        visit '/dashboard'
        click_link_or_button 'Create A New Feed'

        fill_in "feed_name", with: "stumpy"
        fill_in "feed_subdomain", with: "stumpy"
        fill_in "value", with: "stump83"
        check "500px"
        choose "Screen Name"
        click_link_or_button "Create Feed"

        expect(page).to have_selector('img')
      end
    end

    context 'when the user searches for a 500px keyword' do
      it 'creates a new feed and redirects to its show page' do
        log_in_user
        visit '/dashboard'
        click_link_or_button 'Create A New Feed'

        fill_in "feed_name", with: "scotland"
        fill_in "feed_subdomain", with: "scotland"
        fill_in "value", with: "scotland"
        check "500px"
        choose "Keyword"
        click_link_or_button "Create Feed"

        expect(page).to have_selector('img')
      end
    end
  end
end
