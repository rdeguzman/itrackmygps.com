class AddGpsTimestampIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :gps_timestamp
  end
end
