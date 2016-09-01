class CreatePersonalFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :personal_files do |t|
      t.belongs_to  :profile
      t.string      :personal_file_code, null: false
      t.timestamps null: false
    end
  end
end
