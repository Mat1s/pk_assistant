class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.references :car
      t.references :organization
      t.references :service
      t.decimal :price, precision: 8, scale: 3
      t.integer :current_mileage, null: false
      t.integer :next_mileage
      t.boolean :state, default: true
      t.timestamp :next_time
      t.timestamps
    end
  end
end
