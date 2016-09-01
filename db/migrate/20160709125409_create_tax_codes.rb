class CreateTaxCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :tax_codes do |t|
      t.belongs_to  :profile
      t.string      :ptc, null: false
      t.timestamps null: false
    end
  end
end
