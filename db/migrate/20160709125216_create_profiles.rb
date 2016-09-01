class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.belongs_to  :user, index: true
      t.string      :first_name, null: false
      t.string      :last_name, null: false
      t.datetime    :birth_date, null: false
      t.timestamps null: false
    end
  end
end
