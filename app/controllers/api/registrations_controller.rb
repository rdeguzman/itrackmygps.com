class Api::RegistrationsController <  Api::BaseController
  respond_to :json

  def create
    p = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    user = User.new(p)
    if user.save
      render :json=> { :email => user.email }, :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end

end