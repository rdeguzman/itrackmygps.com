class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def gps_activity
    @devices = Device.where(:user_id => current_user.id)

    # Grab the first device if user has multiple devices
    if !@devices.blank?
      device = @devices.first

      @locations = Location.where(:uuid => device.uuid).limit(100)
    else
      @locations = []
    end
  end

end