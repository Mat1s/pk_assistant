class CreateOrganizationAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_addresses do |t|
      t.string :city, null: false
      t.string :street, null: false
      t.string :house_number, null: false
      t.string :phone, null: false, limit: 15
      t.references :organization
      t.timestamps
    end
  end
end
