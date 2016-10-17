class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.belongs_to :school
      t.string  :name
      t.timestamps null: false
    end
  end
end
