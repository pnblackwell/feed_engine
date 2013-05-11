require 'spec_helper'

describe 'visitor views the home page' do

  it 'allows the visitor to search by a Flickr user name' do
    visit '/'
    expect(page).to have_content('Search by flickr user name')
  end

  describe 'visitor searches by Flickr User Name' do

    it 'displays content in descending order of time created' do
      visit '/'
      fill_in :username, with: "jcasimir"
      click_button "Search"
      expect(current_path).to eq feeds_path
      expect(page).to have_selector('img')
    end
  end
end