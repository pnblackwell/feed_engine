require 'spec_helper'

describe 'Sign up with Twitter' do
  it 'asks for an email address and logs the user in' do
    visit root_path
    mock_auth_hash
    click_link "signin"
    fill_in 'user[email]', with: 'user@example.com'
    click_button 'Submit'

    save_and_open_page

    expect(current_path).to eq dashboard_path
    expect(page).to have_content 'mockuser'
    expect(page).to have_content 'Sign out'
    expect(page).to_not have_content "Sign in with twitter"
  end

end
