require 'spec_helper'

describe 'Home Page' do
  include_context 'login'

  context 'not logged in' do
    it 'should have "Login" and "Sign Up" links' do
      visit root_path
      page.should have_link "Login"
      page.should have_link "Sign Up"
    end
  end

  context 'logged in' do
    it 'should have "Logout", "Edit Account", "Devices" links' do
      login_user

      page.should have_link "Logout"
      page.should have_link "Edit account"
      page.should have_link "Devices"

      logout
    end


  end

end