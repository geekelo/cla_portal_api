# frozen_string_literal: true

class CreateClaRoles < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_roles do |t|
      t.string :name, null: false
      t.timestamps
    end

    # Add unique constraint separately
    add_index :cla_roles, :name, unique: true
  end

  def down
    drop_table :cla_roles
  end
end
