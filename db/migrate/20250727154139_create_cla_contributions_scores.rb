class CreateClaContributionsScores < ActiveRecord::Migration[7.1]
  def up
    create_table :cla_contributions_scores do |t|
      t.references :cla_contribution, null: true, foreign_key: false
      t.references :cla_user, null: true, foreign_key: false
      t.references :cla_cohort, null: true, foreign_key: false
      t.integer :score, null: true, default: 0

      t.timestamps
    end

    # Ensure uniqueness of contribution_id, user_id and cohort_id pair
    add_index :cla_contributions_scores, [:cla_contribution_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_contributions_scores_on_contribution_user_cohort'
  end

  def down
    remove_index :cla_contributions_scores, name: 'index_cla_contributions_scores_on_contribution_user_cohort'
    drop_table :cla_contributions_scores
  end
end
