require 'spec_helper'

describe 'Devices Page' do
  include_context 'login'

  it 'should have 3 devices' do
    device = FactoryGirl.build(:device)
    device.user_id = user.id
    device.save

    user.devices.size.should == 1

    login_user

    click_link "Devices"
    #save_and_open_page

    find('table#devices').should have_content "#{device.uuid}"

    logout
  end

end