class ChangeContributionsScoresToUuid < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing index first
    remove_index :cla_contributions_scores, name: 'index_cla_contributions_scores_on_contribution_user_cohort'
    
    # Drop the table and recreate with UUID primary key
    drop_table :cla_contributions_scores
    
    create_table :cla_contributions_scores, id: :uuid do |t|
      t.references :cla_contribution, type: :uuid, null: true, foreign_key: false
      t.references :cla_user, type: :string, null: true, foreign_key: false
      t.references :cla_cohort, type: :integer, null: true, foreign_key: false
      t.references :cla_course, type: :uuid, null: true, foreign_key: false
      t.integer :score, null: true, default: 0

      t.timestamps
    end

    # Recreate the index
    add_index :cla_contributions_scores, [:cla_contribution_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_contributions_scores_on_contribution_user_cohort'
  end

  def down
    # Remove the index
    remove_index :cla_contributions_scores, name: 'index_cla_contributions_scores_on_contribution_user_cohort'
    
    # Drop the table and recreate with integer primary key
    drop_table :cla_contributions_scores
  end
end 