class MapperController < ApplicationController
  before_filter :authenticate_user!, :only => :current

  def current
    @user_id = current_user.id
  end

  def access
    if params[:u].blank?
      redirect_to :restricted
    else
      @username = params[:u]
      users = User.where(:username => @username)
      if users.empty?
        redirect_to :restricted
      end
    end
  end

  def restricted

  end

  def live
    p = params.require(:user).permit(:username, :pin)

    @username = p[:username]
    users = User.where(:username => @username)
    if users.empty?
      redirect_to :restricted
    else

      if is_pin_valid?(p[:pin])

        user = users.first
        if user.pin != p[:pin]
          flash[:error] = "Incorrect Pin"
          render :access, :u => @username
        else
          @user_id = user.id
          render :current
        end

      else
        flash[:error] = "Invalid Pin"
        render :access, :u => @username
      end

    end
  end

  private
    def is_pin_valid?(pin)
      if pin.length != 4
        return false
      else
        return /\A\d+\z/ === pin
      end
    end

end