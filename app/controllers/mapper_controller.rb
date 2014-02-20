class MapperController < ApplicationController
  before_filter :authenticate_user!, :only => :current

  def current
  end

  def access

  end

end