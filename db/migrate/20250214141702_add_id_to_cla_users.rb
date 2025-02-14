# frozen_string_literal: true

class AddIdToClaUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_users, :id, :string, null: true

    # Optionally set existing `user_id` as `id` for consistency
    # execute "UPDATE cla_users SET id = user_id"

    # If you want to make `id` the primary key, uncomment the next line:
    # execute "ALTER TABLE cla_users ADD PRIMARY KEY (id)"
  end

  def down
    remove_column :cla_users, :id
  end
end
