class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :instructions
      t.datetime :start_date
      t.datetime :end_date
      t.integer :status

      t.timestamps null: false
    end
  end
end
