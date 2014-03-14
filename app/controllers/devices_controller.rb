class DevicesController < ApplicationController
  def index
    if user_signed_in?
      @devices = get_devices(current_user.id)
    else
      jsonData = {}

      users = User.where(:id => params[:user_id], :access_token => params[:access_token])

      if users.empty?
        jsonData[:valid] = false
        jsonData[:error] = 'Invalid access token'
      else
        user = users.first
        devices = get_devices(user.id)

        jsonData[:valid] = true
        jsonData[:devices] = devices
      end
    end

    respond_to do |format|
        format.html # index.html.erb
        format.json { render :json => jsonData }
    end
  end

  private
    def get_devices(user_id)
      Device.where(:user_id => user_id)
    end
end
