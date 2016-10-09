class CreateJoinTableSubjectTeacher < ActiveRecord::Migration[5.0]
  def change
    create_join_table :subjects, :users do |t|
      t.index [:subject_id, :user_id]
    end
  end
end
