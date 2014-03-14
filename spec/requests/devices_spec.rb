require 'spec_helper'

describe 'API' do
  let(:user)          { FactoryGirl.create(:user) }
  let(:access_token)  { user.access_token }

  # We use let! here to be invoked similar to a before block
  # See https://www.relishapp.com/rspec/rspec-core/v/2-11/docs/helper-methods/let-and-let
  let!(:device)       { FactoryGirl.create(:device, user_id: user.id) }


  it 'gets /devices with access_token' do
    get devices_path, :user_id => user.id, :access_token => access_token, :format => :json

    expect(response).to be_success
    json = JSON.parse(response.body)

    json.has_key?('valid').should == true
    json.has_key?('devices').should == true

    expect(json['valid']).to be_true
    expect(json['devices']).to be_a_kind_of(Array)

    actual_device = json['devices'].first
    uuid = actual_device['uuid']

    expect(uuid).to eq(device.uuid)
  end

  it 'gets /devices with no or invalid access_token' do
    get devices_path, :user_id => user.id, :access_token => '', :format => :json

    expect(response).to be_success
    json = JSON.parse(response.body)

    json.has_key?('valid').should == true
    json.has_key?('error').should == true

    expect(json['valid']).to be_false
    expect(json['error']).to eq("Invalid access token")
  end
end