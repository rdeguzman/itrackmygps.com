class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string  :device_id, :null => false
      t.integer :gps_timestamp, :limit => 8, :default => 0, :null => false
      t.float   :gps_latitude, :default => 0.0, :null => false
      t.float   :gps_longitude, :default => 0.0, :null => false
      t.float   :gps_speed
      t.float   :gps_heading

      t.timestamps
    end
  end
end
