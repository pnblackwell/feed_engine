require 'spec_helper'

describe 'visitor views the home page' do
  it 'allows the visitor to search by a Flickr user name' do
    visit '/'
    expect(page).to have_content('Search by Flickr User Name')
  end

  describe 'visitor searches by Flickr User Name' do
    it 'displays content in descending order of time created' do
      pending
    end
  end
end