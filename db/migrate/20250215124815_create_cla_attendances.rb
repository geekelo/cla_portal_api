class CreateClaAttendances < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_attendances do |t|
      t.references :cla_live_class, null: true, foreign_key: false
      t.references :cla_user, null: true, foreign_key: false
      t.references :cla_cohort, null: true, foreign_key: false
      t.boolean :present, null: true, default: false

      t.timestamps
    end

    # Ensure uniqueness of live_class_id and user_id pair
    add_index :cla_attendances, [:cla_live_class_id, :cla_user_id], unique: true
  end

  def down
    remove_index :attendances, [:cla_live_class_id, :cla_user_id]
    drop_table :attendances
  end
end
