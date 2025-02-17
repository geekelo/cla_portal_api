class ChangeClaUserAndLiveClassColumnsInClaAttendances < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing reference columns
    remove_reference :cla_attendances, :cla_live_class, foreign_key: false, index: true
    remove_reference :cla_attendances, :cla_user, foreign_key: false, index: true

    # Add new cla_live_class_id column as a string, not allowing null values
    add_column :cla_attendances, :cla_live_class_id, :string, null: false, default: ''
    add_index :cla_attendances, :cla_live_class_id

    # Add new cla_user_id column as a string, not allowing null values
    add_column :cla_attendances, :cla_user_id, :string, null: false, default: ''
    add_index :cla_attendances, :cla_user_id
  end

  def down
    # Remove the string columns and their indexes
    remove_index :cla_attendances, :cla_live_class_id
    remove_column :cla_attendances, :cla_live_class_id
    remove_index :cla_attendances, :cla_user_id
    remove_column :cla_attendances, :cla_user_id

    # Re-add the original reference columns
    add_reference :cla_attendances, :cla_live_class, type: :uuid, foreign_key: false, null: true, index: true
    add_reference :cla_attendances, :cla_user, type: :uuid, foreign_key: false, null: true, index: true
  end
end
