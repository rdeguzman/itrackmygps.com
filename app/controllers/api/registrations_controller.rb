class Api::RegistrationsController <  Api::BaseController
  respond_to :json

  def create
    p = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    user = User.new(p)
    if user.save

      devices = Device.where(:uuid => params[:uuid])

      if devices.empty?
        d = Device.new
        d.uuid = params[:uuid]
      else
        d = devices.first
      end

      d.user_id = user.id
      d.save

      render :json=> { :valid => true,
                       :username => user.username,
                       :email => user.email,
                       :device_id => d.id }, :status=>201
    else

      error_messages = user.errors.full_messages.join(". ")
      render :json=> { :valid => false,
                       :errors => error_messages }
    end
  end

end