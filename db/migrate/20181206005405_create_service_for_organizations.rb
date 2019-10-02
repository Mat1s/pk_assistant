class CreateServiceForOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :service_for_organizations do |t|
      t.references :organization, foreign_key: true
      t.references :service, foreign_key: true
      t.timestamps
    end
    add_index :service_for_organizations, [:organization_id, :service_id],
     unique: true, name: 'uniq_service_for_organization'
  end
end
