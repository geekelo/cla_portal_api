class ChangeClaUserIdToUuidInClaAssignments < ActiveRecord::Migration[7.1]
  def up
    change_column :cla_assignments, :cla_user_id, :uuid, null: false
  end

  def down
    change_column :cla_assignments, :cla_user_id, :uuid, null: true
  end
end
