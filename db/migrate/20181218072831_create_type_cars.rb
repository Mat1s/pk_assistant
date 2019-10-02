class CreateTypeCars < ActiveRecord::Migration[5.2]
  def change
    create_table :type_cars do |t|
      t.string :make
      t.string :model
      t.integer :year
    end
  end
end
