class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.belongs_to  :profile
      t.string      :phone_num
      t.timestamps null: false
    end
  end
end
