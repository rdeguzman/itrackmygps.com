require 'spec_helper'

describe 'Home Page' do
  include_context 'login'

  it 'should have "Login" and "Sign Up" links' do
    visit root_path
    page.should have_link "Login"
    page.should have_link "Sign Up"
  end

  it 'should have "Logout" and "Edit Account" links' do
    login_user

    page.should have_link "Logout"
    page.should have_link "Edit account"

    logout
  end
end