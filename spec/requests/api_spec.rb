require 'spec_helper'

describe 'API' do

  it 'sign up' do
    uuid = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx-1'
    u = {
      :username => 'rndguzmanjr',
      :email => 'rndguzmanjr@gmail.com',
      :password => 'password',
      :password_confirmation => 'password'
    }

    post api_user_registration_path, :user => u, :uuid => uuid

    expect(response).to be_success
    json = JSON.parse(response.body)

    users = User.where(:username => u[:username])
    user_id = users.empty? ? nil : users.first.id
    devices = Device.where(:user_id => user_id, :uuid => uuid)
    device = devices.empty? ? nil : devices.first

    json.has_key?("username").should == true
    json.has_key?("email").should == true
    json.has_key?("device_id").should == true

    json['username'].should == u[:username]
    json['email'].should == u[:email]
    json['device_id'].should == device.id
  end

end