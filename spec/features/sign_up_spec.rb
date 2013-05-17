require 'spec_helper'

describe 'Sign up with Twitter' do
  it 'asks for an email address and logs the user in' do
    mock_auth_hash
    visit root_path
    click_link "signin"
    fill_in 'user[email]', with: 'user@example.com'
    click_button 'Submit'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in as mockuser!'
    expect(page).to_not have_content "Sign in with twitter"
  end

end