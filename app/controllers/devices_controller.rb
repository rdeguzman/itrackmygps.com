class DevicesController < ApplicationController
  def index
    authenticate_user!
    @devices = Device.where(:user_id => current_user.id)
  end

end
