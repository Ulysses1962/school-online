class CreateMarks < ActiveRecord::Migration[5.0]
  def change
    create_table :marks do |t|
      t.belongs_to :student, null: false, index: true
      t.belongs_to :subject, null: false, index: true
      t.belongs_to :thematicplan, null: true
      t.decimal    :mark, null: false
      t.integer    :mark_type, null: false
      t.timestamps
    end
  end
end
