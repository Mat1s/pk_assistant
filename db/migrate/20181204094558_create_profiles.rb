class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :image
      t.string :firstname, null: false
      t.string :surname, null: false
      t.string :nickname, null: false
      t.date :birthday
      t.string :address, null: false
      t.references :user
      t.timestamps
    end
  end
end
