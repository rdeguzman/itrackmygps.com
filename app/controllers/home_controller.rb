class HomeController < ApplicationController

  def index
    @total_users = User.count
    @total_updates = Location.count
  end

  def privacy
  end

end
