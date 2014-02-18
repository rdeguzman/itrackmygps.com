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

  end

end