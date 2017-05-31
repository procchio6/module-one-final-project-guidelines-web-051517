class CreateRidesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.references :user
      t.references :driver
      t.float :fare
      t.timestamps
    end
  end
end
