class AddAasmStateToOrganization < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :aasm_state, :string
    remove_column :organizations, :visiability
    remove_column :organizations, :checked
  end
end
