class CreateThematicPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :thematic_plans do |t|
        t.belongs_to :school, index: true
        t.belongs_to :subject, index: true
        t.integer :academic_class, null: false, index: true
        t.string :academic_parallel, null: false
        t.string :theme_name
      t.timestamps
    end
  end
end
