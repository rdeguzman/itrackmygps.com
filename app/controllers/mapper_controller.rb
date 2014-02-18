class MapperController < ApplicationController
  before_filter :authenticate_user!

  def current
  end

end