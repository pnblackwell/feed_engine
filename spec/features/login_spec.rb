require 'spec_helper'

describe 'login user with flickr' do

  it "can sign in user with Twitter account" do
    visit '/'
    mock_auth_hash # OmniauthMockHelper.mock_auth_hash
    click_link "Sign in with twitter"

    page.should have_content("mockuser")
    page.should have_content("Sign out")
  end

end