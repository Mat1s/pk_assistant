class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.string :make, null: false
      t.string :model, null: false
      t.integer :year, null: false
      t.string :vehicle_type, null: false
      t.string :fuel_type, null: false
      t.integer :cubic_capacity, null: false
      t.string :transmission, null: false
      t.integer :purchase_date, null: false
      t.integer :mileage, default: 0
      t.text :description
      t.references :user
      t.timestamps
    end
  end
end
