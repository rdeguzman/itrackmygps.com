class AddDistanceIntervalToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :distance_interval, :integer, :default => -1
  end
end
