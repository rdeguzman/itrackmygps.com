require 'spec_helper'

describe 'Sign Up Page' do

  it 'has username, email, password, password_confirmation and pin' do
    visit new_user_registration_path

    page.should have_field "Username"
    page.should have_field "Email"
    page.should have_field "Password"
    page.should have_field "Password confirmation"
    page.should have_field "Pin"
  end

  it 'sign up' do
    visit new_user_registration_path

    username = 'rdeguzman'
    pin = '1234'

    fill_in "Username", :with => username
    fill_in "Email", :with => "rndguzmanjr@yahoo.com"

    # fix ambiguous http://techblog.fundinggates.com/blog/2012/08/capybara-2-0-upgrade-guide/
    find('#user_password').set 'passw0rd'
    find('#user_password_confirmation').set 'passw0rd'

    fill_in "Pin", :with => pin

    click_button "Sign Up"

    page.should have_content "Welcome! You have signed up successfully."

    users = User.where(:username => username)
    user = users.first
    user.pin.should == pin
  end

end