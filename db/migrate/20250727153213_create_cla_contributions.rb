class CreateClaContributions < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_contributions, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.datetime :due_date, null: false

      # Foreign keys
      t.references :cla_course, type: :uuid, null: true, foreign_key: false
      t.references :cla_user, type: :uuid, null: true, foreign_key: false
      t.references :cla_cohort, type: :uuid, null: true, foreign_key: false

      t.timestamps
    end

    add_index :cla_contributions, [:cla_course_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_contributions_on_course_user_cohort'
  end

  def down
    remove_index :cla_contributions, name: 'index_cla_contributions_on_course_user_cohort'
    drop_table :cla_contributions
  end
end
