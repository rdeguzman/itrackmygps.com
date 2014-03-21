require 'spec_helper'

describe 'API' do
  let(:uuid) {'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxx-1'}

  context 'registration' do
    user_params = {
      :username => 'rndguzmanjr',
      :email => 'rndguzmanjr@gmail.com',
      :password => 'password',
      :password_confirmation => 'password',
      :pin => '1234'
    }

    let(:user) { user_params }

    it 'sign up' do
      post api_user_registration_path, :user => user, :uuid => uuid

      expect(response).to be_success
      json = JSON.parse(response.body)

      users = User.where(:username => user[:username])
      current_user = users.first
      user_id = users.empty? ? nil : current_user.id
      devices = Device.where(:user_id => user_id, :uuid => uuid)
      device = devices.empty? ? nil : devices.first

      current_user.pin.should == user[:pin]
      current_user.access_token.should_not be_nil

      json.has_key?("valid").should == true
      json.has_key?("username").should == true
      json.has_key?("email").should == true
      json.has_key?("device_id").should == true

      json['valid'].should == true
      json['username'].should == user[:username]
      json['email'].should == user[:email]
      json['device_id'].should == device.id
    end

    it 'email already taken' do
      u = FactoryGirl.create(:user)

      d = FactoryGirl.build(:device)
      d.user_id = u.id
      d.save

      post api_user_registration_path, :user => user, :uuid => uuid

      expect(response).to be_success
      json = JSON.parse(response.body)
      #puts json

      json.has_key?("valid").should == true
      json.has_key?("errors").should == true

      json['valid'].should == false
      json['errors'].should == 'Username has already been taken'
    end
  end

  context 'sessions' do
    let(:user) { FactoryGirl.create :user }

    it 'login' do
      post api_user_session_path, :username => user.username,
                                  :password => user.password,
                                  :uuid => uuid

      expect(response).to be_success

      json = JSON.parse(response.body)
      json.has_key?("valid").should == true
      json['valid'].should == true

      json.has_key?("email").should == true
      json['email'].should == user.email

      json.has_key?("pin").should == true
      json['pin'].should == user.pin
    end

    it 'invalid username' do
      post api_user_session_path, :username => "unknown_user",
                                  :password => "invalid_password",
                                  :uuid => uuid

      expect(response).to be_success

      json = JSON.parse(response.body)
      json.has_key?("valid").should == true
      json.has_key?("errors").should == true
      json['valid'].should == false
      json['errors'].should == "Sorry, but the username does not exist. Please REGISTER first."
    end

    it 'invalid password' do
      post api_user_session_path, :username => user.username,
                                  :password => "invalid_password",
                                  :uuid => uuid

      expect(response).to be_success

      json = JSON.parse(response.body)
      json.has_key?("valid").should == true
      json.has_key?("errors").should == true
      json['valid'].should == false
      json['errors'].should == "Invalid password."
    end

  end

end
