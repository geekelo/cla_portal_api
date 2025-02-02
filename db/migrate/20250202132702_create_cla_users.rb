# frozen_string_literal: true

class CreateClaUsers < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_users, id: false do |t|
      t.string :user_id, primary_key: true # Custom primary key
      t.string :name, null: false
      t.string :email, null: false
      t.references :cla_cohort, foreign_key: false, null: true
      t.references :cla_role, foreign_key: true, null: false # student, facilitator, alumni, admin

      t.string :password_digest
      t.timestamps
    end

    # Add unique constraint separately
    add_index :cla_users, :email, unique: true
  end

  def down
    drop_table :cla_users
  end
end
