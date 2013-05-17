require 'spec_helper'

describe 'login user with twitter' do

  it "allows existing user to log in via twitter" do
    User.create(username: 'mockuser')

    visit root_path
    mock_auth_hash # OmniauthMockHelper.mock_auth_hash
    click_link "signin"

    expect(current_path).to eq dashboard_path
    save_and_open_page
    expect(page).to have_content 'Account information for: mockuser'
    expect(page).to_not have_content "Sign in with twitter"
  end

end
