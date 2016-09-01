class CreateTariffications < ActiveRecord::Migration[5.0]
  def change
    create_table :tariffications do |t|
      t.belongs_to  :user, index: true
      t.belongs_to  :subject, index: true
      t.integer     :academic_year, null: false, index: true
      t.integer     :academic_class, null: false, index: true
      t.string      :academic_parallel, null: false, index: true
      t.integer     :academic_group
      t.decimal     :tariff_hours, null: false
      t.timestamps null: false
    end
  end
end
