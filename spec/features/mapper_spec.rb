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

    context 'invalid pin' do
      before(:each) do
        visit map_access_path(:u => user.username)
      end

      after(:each) do
        click_button 'Submit'
        page.should have_content "Invalid Pin"
      end

      it 'incorrect pin if not numeric' do
        fill_in 'PIN', :with => 'abcd'
      end

      it 'incorrect pin if more than 4 digits' do
        fill_in 'PIN', :with => '12345'
      end

      it 'incorrect pin if has special character' do
        fill_in 'PIN', :with => '123.0'
      end
    end

    it 'has correct pin' do
      visit map_access_path(:u => user.username)
      fill_in 'PIN', :with => '1234'
      click_button 'Submit'
      page.should_not have_content "Incorrect Pin"
    end

  end

end