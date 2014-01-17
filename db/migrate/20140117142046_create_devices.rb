class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references  :user
      t.string      :uuid
      t.timestamps
    end
  end
end
