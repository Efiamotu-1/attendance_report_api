class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :course_description
      t.string :department
      t.boolean :course_priority
      t.integer :num_of_classes_held, default: 0
      t.integer :num_of_classes_attended, default: 0
      t.string :course_title
      t.integer :percentage, default: 100.0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
