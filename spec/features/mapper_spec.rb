require 'spec_helper'

describe 'Map' do
  include_context 'login'

  context 'not logged in' do
    it 'should authenticate on /current' do
      visit current_map_path
      page.should have_content "You need to sign in or sign up before continuing."
      page.should have_link "Login"
      page.should have_link "Sign Up"
    end

    it 'redirect to /restricted if no username supplied on /access' do
      visit map_access_path
      page.should have_content "You are not allowed to access this page directly."
    end

    it 'redirect to /restricted if username supplied on /access does not exist' do
      visit map_access_path(:u => "foobar")
      page.should have_content "You are not allowed to access this page directly."
    end

    it 'should display a form on /access' do
      visit map_access_path(:u => user.username)
      page.should have_field "PIN"
    end
  end

end