class ChangeClaUserColumnInClaCourses < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing reference column (creates a column named cla_user_id)
    remove_reference :cla_courses, :cla_user, foreign_key: false, index: true

    # Add a new cla_user_id column as a string, not allowing null values
    add_column :cla_courses, :cla_user_id, :string, null: false, default: ''
    add_index :cla_courses, :cla_user_id
  end

  def down
    # Remove the string column and its index
    remove_index :cla_courses, :cla_user_id
    remove_column :cla_courses, :cla_user_id

    # Re-add the original reference column (adjust type and null option as needed)
    add_reference :cla_courses, :cla_user, type: :uuid, foreign_key: false, null: true, index: true
  end
end
