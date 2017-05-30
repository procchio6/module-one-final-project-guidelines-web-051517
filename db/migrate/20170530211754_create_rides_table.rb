class CreateRidesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :rides do |t|
      t.references :users
      t.references :drivers
      t.float :fare
      t.datetime :date
    end
  end
end
