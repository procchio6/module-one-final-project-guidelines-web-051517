class CreateDriversTable < ActiveRecord::Migration[5.0]
  def change
    create_table :drivers do |t|
      t.string :medallion
      t.string :name
    end
  end
end
