require 'spec_helper'

describe 'Create new feed' do
  it 'creates a new feed for a user' do
    visit new_feed_path
    save_and_open_page
    fill_in "feed_name", with: "Jen's Pics"
    fill_in "value", with: "white raven photography"
    click_button "Create Feed"

    expect(page).to have_selector('img')
  end
end