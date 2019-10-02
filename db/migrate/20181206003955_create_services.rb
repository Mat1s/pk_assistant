class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name_en
      t.string :name_ru
      t.string :name_es
      t.references :service_type
    end
  end
end
