class CreateRanks < ActiveRecord::Migration[5.0]
  def change
    create_table :ranks do |t|
      t.belongs_to  :student, null: false, index: true
      t.belongs_to  :subject, null: true
      t.integer     :rank_type
      t.integer     :rank_level
      t.timestamps
    end
  end
end
