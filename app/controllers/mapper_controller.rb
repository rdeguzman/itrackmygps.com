class MapperController < ApplicationController
  before_filter :authenticate_user!, :only => :current

  def current
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

end