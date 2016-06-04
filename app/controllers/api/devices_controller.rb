class Api::DevicesController < Api::BaseController
  def index
    jsonData = {}

    users = User.where(:id => params[:user_id], :access_token => params[:access_token])

    if users.empty?
      jsonData[:valid] = false
      jsonData[:error] = 'Invalid access token'
    else
      user = users.first
      devices = get_device_location(user.id)

      jsonData[:valid] = true
      jsonData[:devices] = devices
    end

    respond_to do |format|
        format.json { render :json => jsonData }
    end
  end

  private
    def get_device_location(user_id)
      uuids = []
      devices = Device.where(:user_id => user_id)
      devices.each do |device|

        locations = Location.where(:uuid => device.uuid).order("created_at DESC").limit(1)

        if(locations.size > 0)
          location = locations.first

          data = {}
          data[:uuid] = device.uuid
          data[:user_id] = user_id
          data[:gps_latitude] = location.gps_latitude
          data[:gps_longitude] = location.gps_longitude
          data[:gps_timestamp] = location.gps_timestamp
          data[:gps_speed] = location.gps_speed
          data[:gps_heading] = location.gps_heading
        end

        uuids.push(data)
      end

      return uuids
    end

end