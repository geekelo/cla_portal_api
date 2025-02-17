class AddStartAndEndDateToClaCourses < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_courses, :start_date, :date, null: true
    add_column :cla_courses, :end_date, :date, null: true
  end

  def down
    remove_column :cla_courses, :start_date
    remove_column :cla_courses, :end_date
  end
end
