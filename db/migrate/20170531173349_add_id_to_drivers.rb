class AddIdToDrivers < ActiveRecord::Migration[5.0]
  def change
    add_column :drivers, :id, :primary_key
  end
end
