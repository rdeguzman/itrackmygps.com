class Api::SessionsController < Api::BaseController
  respond_to :json

  def create
    users = User.where(:username => params[:username])
    if users.empty?
      render :json => { :valid => false, :errors => "Sorry, but the username does not exist. Please REGISTER first." }
    else
      user = users.first
      if user.valid_password?(params[:password]) and not params[:uuid].nil?
        device = find_and_save_device(user.id, params[:uuid])

        render :json => { :valid => true, :email => user.email, :pin => user.pin }
      else
        render :json => { :valid => false, :errors => "Invalid password." }
      end
    end

  end

end
