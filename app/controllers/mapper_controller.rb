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
    @username = params[:user][:username]
    users = User.where(:username => @username)
    if users.empty?
      redirect_to :restricted
    else
      user = users.first
      if user.pin != params[:user][:username]
        flash[:error] = "Incorrect pin"
        render :access, :u => @username
      end
    end
  end

end