require 'spec_helper'

describe 'Sign up with Twitter' do
  it 'asks for an email address and logs the user in' do
    mock_auth_hash
    visit root_path
    click_link "Sign in with twitter"
    # omniauth will say they logged in successfully
    fill_in 'user[email]', with: 'user@example.com'
    click_button 'Submit'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Signed in as mockuser!'
    expect(page).to_not have_content "Sign in with twitter"
  end
  
  # context 'when the user tries to sign in via Twitter with an email set' do
  #   # we want the user to sign in using twitter and then redirect them to the root path
  #   it 'redirects them back to the root and logs them in' do
  #     mock_auth_hash
  #     visit root_path
  #     click_link "Sign in with twitter"

  #     expect(current_path).to eq(root_path)

  #     expect(page).to have_content('Search by flickr user name')
  #   end
    
  #   # we want the user to sign in using twitter and then redirect them to a new page where they
  #   # are prompted to give their email
  #   it 'creates a new user and recognizes that email needs to be input' do
  #     visit '/'
  #     click_link "Sign in with twitter"

  #     expect(page).to have_content('Please enter your email address')
  #   end

  # end


  # context 'Email validation of a new user' do

  #   it 'sends the person to their main page after a successful login' do

  #   end

  #   it 'puts the person back on the edit page' do
  #   end
  # end
end