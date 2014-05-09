class AddProviderToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :provider, :string
  end
end
