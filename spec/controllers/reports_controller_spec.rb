require 'spec_helper'

describe ReportsController do

  before (:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'location_history'" do

    it "successful" do
      get :gps_activity
      response.should be_success
      expect(assigns(:locations)).to be_empty
    end

  end

end
