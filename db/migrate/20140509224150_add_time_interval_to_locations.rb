class AddTimeIntervalToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :time_interval, :integer, :default => -1
  end
end
