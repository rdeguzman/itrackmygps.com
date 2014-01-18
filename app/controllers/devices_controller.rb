class DevicesController < ApplicationController
  def index
    @devices = Device.where(:user_id => current_user.id)
  end
end
