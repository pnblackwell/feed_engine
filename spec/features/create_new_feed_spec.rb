require 'spec_helper'

describe 'Create new feed' do
  it 'creates a new feed for a user' do
    visit new_feed_path
    fill_in "feed_name", with: "Jen's Pics"
    fill_in "feed_subdomain", with: "jenspics"
    fill_in "value", with: "white raven photography"
    click_link_or_button "Create Feed"

    expect(page).to have_selector('img')
  end
end
