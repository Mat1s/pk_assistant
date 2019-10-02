class CreateTypeOfServices < ActiveRecord::Migration[5.2]
  def change
    create_table :service_types do |t|
      t.string :type_en, null: false
      t.string :type_ru, null: false
      t.string :type_es
    end
  end
end
