require 'spec_helper'

describe 'API' do

  it 'registers' do
    u = {
      :name => 'rupert',
      :email => 'rupert@2rmobile.com',
      :password => 'password',
      :password_confirmation => 'password'
    }

    post api_user_registration_path, :user => u

    expect(response).to be_success
    json = JSON.parse(response.body)

    json['email'].should == u[:email]
  end

end