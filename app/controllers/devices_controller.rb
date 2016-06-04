class DevicesController < ApplicationController
  def index
    authenticate_user!
    @devices = Device.where(:user_id => current_user.id)
  end

  def destroy
    device = Device.find(params[:id])
    device.destroy
    redirect_to devices_path
  end

end
