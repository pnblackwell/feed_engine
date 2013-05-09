require 'spec_helper'

describe 'login user with flickr' do

  it "logs in a user with their flickr account" do
    visit root_path
    click_on "Sign in with flickr"
    # do some stuff to authenticate yourself

    expect(page).to have_content "Logged in as dannytestapp"
  end
end