require 'spec_helper'

describe 'Home page flickr user search' do
  
  it 'returns photos for a user' do
    visit '/'
    fill_in 'user_field', with: "dannytestapp"
    click_on 'Search'

    expect(page).to have_selector 'img'
  end
end