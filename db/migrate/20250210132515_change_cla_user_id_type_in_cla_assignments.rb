class ChangeClaUserIdTypeInClaAssignments < ActiveRecord::Migration[7.1]
  def up
    # Change `cla_user_id` from `uuid` to `string` or `integer` (depending on your data model)
    change_column :cla_assignments, :cla_user_id, :string, null: false
  end

  def down
    # Rollback to UUID if needed
    change_column :cla_assignments, :cla_user_id, :uuid, null: false
  end
end
