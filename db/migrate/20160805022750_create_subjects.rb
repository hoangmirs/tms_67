class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.text :instructions

      t.timestamps null: false
    end
  end
end
