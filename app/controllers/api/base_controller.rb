class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  private
    def find_and_save_device(user_id, uuid)
      devices = Device.where(:uuid => uuid)

      if devices.empty?
        d = Device.new
        d.uuid = uuid
      else
        d = devices.first
      end

      d.user_id = user_id
      d.save

      return d
    end

end