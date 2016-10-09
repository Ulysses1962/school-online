class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      # Global info
      t.belongs_to  :user, index: true
      t.string      :first_name, null: false
      t.string      :last_name, null: false
      t.datetime    :birth_date, null: false
      # Academic info
      t.integer     :academic_class, null: true, index: true
      t.string      :academic_parallel, null: true, index: true
      t.integer     :academic_group, null: true
      t.string      :parent_name, null: true
      # Address info
      t.string      :address_string
      t.string      :personal_file_code, null: false
      t.string      :ptc, null: false
      # Geocoding data
      t.float       :longitude, null: true
      t.float       :latitude, null: true
      t.timestamps null: false
    end
  end
end
