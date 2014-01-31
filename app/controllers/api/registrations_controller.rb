class Api::RegistrationsController <  Api::BaseController
  respond_to :json

  def create
    p = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    user = User.new(p)
    if user.save
      device = find_and_save_device(user.id, params[:uuid])

      render :json=> { :valid => true,
                       :username => user.username,
                       :email => user.email,
                       :device_id => device.id }, :status=>201
    else

      error_messages = user.errors.full_messages.join(". ")
      render :json=> { :valid => false,
                       :errors => error_messages }
    end
  end

end