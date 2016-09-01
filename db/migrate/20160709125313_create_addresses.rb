class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.belongs_to  :profile
      t.string      :address_string
      # Geocoder data
      t.float       :longitude, null: true
      t.float       :latitude, null: true
      t.timestamps null: false
    end
  end
end
