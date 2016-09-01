class CreateSchools < ActiveRecord::Migration[5.0]
  def change
    create_table :schools do |t|
      t.string  :school_code, null: false
      t.string  :school_name, null: false
      t.string  :school_email, null: false
      t.string  :school_address_string, null: false
      t.string  :school_phone, null: false
      # Geocoder data
      t.float   :longitude, null: true
      t.float   :latitude, null: true
      t.timestamps null: false
    end
  end
end
