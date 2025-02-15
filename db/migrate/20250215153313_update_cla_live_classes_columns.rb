class UpdateClaLiveClassesColumns < ActiveRecord::Migration[7.1]
  def up
    # Remove existing reference columns for cla_user and cla_cohort
    remove_reference :cla_live_classes, :cla_user, foreign_key: false, index: true
    remove_reference :cla_live_classes, :cla_cohort, foreign_key: false, index: true

    # Add new cla_user_id column as a string with null: false using a temporary default.
    add_column :cla_live_classes, :cla_user_id, :string, null: false, default: 'TEMP'
    add_index :cla_live_classes, :cla_user_id

    # Add new cla_cohort_id column as a string with null: false using a temporary default.
    add_column :cla_live_classes, :cla_cohort_id, :string, null: false, default: 'TEMP'
    add_index :cla_live_classes, :cla_cohort_id

    # Remove the temporary defaults so new records don't automatically get 'TEMP'
    change_column_default :cla_live_classes, :cla_user_id, nil
    change_column_default :cla_live_classes, :cla_cohort_id, nil

    # Remove the foreign key on cla_course_id if it exists before changing its type.
    if foreign_key_exists?(:cla_live_classes, column: :cla_course_id)
      remove_foreign_key :cla_live_classes, column: :cla_course_id
    end

    # Change the cla_course_id column type from uuid to string.
    change_column :cla_live_classes, :cla_course_id, :string
  end

  def down
    # Revert cla_course_id back to uuid and re-add its foreign key.
    change_column :cla_live_classes, :cla_course_id, :uuid
    add_foreign_key :cla_live_classes, :cla_courses, column: :cla_course_id

    # Remove the new string columns and their indexes.
    remove_index :cla_live_classes, :cla_user_id
    remove_column :cla_live_classes, :cla_user_id
    remove_index :cla_live_classes, :cla_cohort_id
    remove_column :cla_live_classes, :cla_cohort_id

    # Re-add the original reference columns for cla_user and cla_cohort.
    add_reference :cla_live_classes, :cla_user, type: :uuid, foreign_key: false, null: true, index: true
    add_reference :cla_live_classes, :cla_cohort, foreign_key: false, null: true, index: true
  end
end
