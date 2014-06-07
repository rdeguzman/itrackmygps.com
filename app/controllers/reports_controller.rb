class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def gps_activity
    @devices = Device.where(:user_id => current_user.id)

    # Grab the first device if user has multiple devices
    if !@devices.blank?
      device = @devices.first

      # If there are no dates provided, we provide the last known 100 records
      if params[:date_from].blank? or params[:date_to].blank?
        locations = Location.where(:uuid => device.uuid).order('created_at desc').limit(100)
        @first_timestamp = locations.last.gps_timestamp
        @last_timestamp = locations.first.gps_timestamp

        @locations = Location.where("uuid = ? AND gps_timestamp >= ?",
                                    device.uuid,
                                    @first_timestamp).
                                    order('created_at asc').
                                    paginate(:page => params[:page],
                                             :per_page => params[:per_page] || APP_CONFIG[:per_page])
      else
        @locations = Location.where('uuid = ? AND gps_timestamp >= ? AND gps_timestamp <= ?',
                                    device.uuid,
                                    params[:date_from],
                                    params[:date_to]).order('created_at asc').
                                    paginate(:page => params[:page],
                                             :per_page => params[:per_page] || APP_CONFIG[:per_page])
      end
    else
      @locations = []
    end
  end

end