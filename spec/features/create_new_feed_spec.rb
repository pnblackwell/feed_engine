require 'spec_helper'

describe 'Create new feed' do
  it 'creates a new username feed for a user' do
    visit new_feed_path
    fill_in "feed_name", with: "Jen's Pics"
    fill_in "feed_subdomain", with: "jenspics"
    fill_in "value", with: "white raven photography"
    find(:css, "#feed_searches_attributes_0_search_type_username").set(true)
    click_link_or_button "Create Feed"

    expect(page).to have_selector('img')
  end

  it 'creates a new keyword feed for a user' do
    visit new_feed_path
    fill_in "feed_name", with: "Paul's Pics"
    fill_in "feed_subdomain", with: "paulspics"
    fill_in "value", with: "horses"
    find(:css, "#feed_searches_attributes_0_search_type_keyword").set(true)
    click_link_or_button "Create Feed"
    
    expect(page).to have_selector('img')
  end
end
