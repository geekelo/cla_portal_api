class AddResetPasswordToClaUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_users, :reset_password_token, :string
    add_column :cla_users, :reset_password_sent_at, :datetime
  end

  def down
    remove_column :cla_users, :reset_password_token
    remove_column :cla_users, :reset_password_sent_at
  end
end
