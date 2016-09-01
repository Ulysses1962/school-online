class CreateJoinTablesRoleUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :roles, :users do |t|
       t.index [:user_id, :role_id]
    end
  end
end
