class ChangeNullConstraintOnClaRoleIdInClaUsers < ActiveRecord::Migration[6.0]
    def change
      # Change the column to allow null values
      change_column_null :cla_users, :cla_role_id, true
    end
  end
  