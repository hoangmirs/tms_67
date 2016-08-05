class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.references :user, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :user_course, index: true, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status

      t.timestamps null: false
    end
  end
end
