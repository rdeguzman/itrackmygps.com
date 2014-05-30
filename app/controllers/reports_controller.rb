class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def gps_activity
    @devices = Device.where(:user_id => current_user.id)

    # Grab the first device if user has multiple devices
    if !@devices.blank?
      device = @devices.first

      # If there are no dates provided, we provide the last known 100 records
      if params[:date_from].blank? or params[:date_to].blank?
        @locations = Location.where(:uuid => device.uuid).order('created_at desc').paginate(:page => params[:page])
      else
        @locations = Location.where('uuid = ? AND gps_timestamp >= ? AND gps_timestamp <= ?',
                                    device.uuid,
                                    params[:date_from],
                                    params[:date_to]).paginate(:page => params[:page])
      end
    else
      @locations = []
    end
  end

end