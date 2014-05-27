require 'spec_helper'

describe 'Location History Page' do
  include_context 'login'

  it 'displays form' do
    login_user

    click_link "Location History"

    page.should have_select "Devices"

    page.should have_css('#date_from')
    page.should have_css('#date_to')

    page.should have_button "Submit"

    #save_and_open_page

    logout
  end

end