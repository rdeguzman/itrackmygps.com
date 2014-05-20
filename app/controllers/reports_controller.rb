class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def gps_activity
    @devices = Device.where(:user_id => current_user.id)
  end
end