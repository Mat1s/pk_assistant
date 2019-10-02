class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name, null: false, unique: true
      t.string :email, null: false
      t.string :phone, null: false, limit: 15
      t.boolean :visiability, default: true
      t.boolean :checked, default: false
      t.references :service_type
      t.references :user
      t.timestamps
    end
  end
end
