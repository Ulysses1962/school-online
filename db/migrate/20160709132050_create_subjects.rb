class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string  :name
      t.integer :level
      t.timestamps null: false
    end
  end
end
