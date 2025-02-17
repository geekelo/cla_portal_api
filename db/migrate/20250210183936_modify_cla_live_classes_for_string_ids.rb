class ModifyClaLiveClassesForStringIds < ActiveRecord::Migration[7.1]
  def up
    # Add the new columns as strings
    add_column :cla_live_classes, :cla_cohort_id, :string
    add_column :cla_live_classes, :cla_user_id, :string

    # Remove the foreign key constraint on cla_course_id before changing its type.
    # (Assuming the referenced table is `cla_courses`.)
    remove_foreign_key :cla_live_classes, column: :cla_course_id

    # Change the column type from UUID to string.
    change_column :cla_live_classes, :cla_course_id, :string
  end

  def down
    # Revert the type of cla_course_id from string back to UUID.
    change_column :cla_live_classes, :cla_course_id, :uuid

    # Re-add the foreign key constraint.
    add_foreign_key :cla_live_classes, :cla_courses, column: :cla_course_id

    # Remove the added columns.
    remove_column :cla_live_classes, :cla_cohort_id
    remove_column :cla_live_classes, :cla_user_id
  end
end
