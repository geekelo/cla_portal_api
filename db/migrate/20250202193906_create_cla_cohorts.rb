class CreateClaCohorts < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_cohorts do |t|
      t.string :name, null: false
      t.references :cla_course, foreign_key: false, null: true

      t.timestamps
    end

    # Add unique constraint separately
    add_index :cla_cohorts, :name, unique: true
  end

  def down
    drop_table :cla_cohorts
  end
end
