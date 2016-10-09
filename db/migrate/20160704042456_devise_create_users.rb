class DeviseCreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string    :email, null: true, default: ""
      t.string    :username, null: false, default: ""
      t.string    :encrypted_password, null: false, default: ""
      t.string    :reset_password_token
      t.datetime  :reset_password_sent_at
      t.integer   :sign_in_count, default: 0, null: false
      t.datetime  :current_sign_in_at
      t.datetime  :last_sign_in_at
      t.inet      :current_sign_in_ip
      t.inet      :last_sign_in_ip
      # School attribute
      t.belongs_to :school, index: true, null: false
      # Subclasses attributes
      t.string    :type
      t.timestamps null: false
    end

    add_index :users, :reset_password_token, unique: true
  end
end
