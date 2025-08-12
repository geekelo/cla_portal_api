class CreateClaCbtsScores < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing index first
    remove_index :cla_cbts_scores, name: 'index_cla_cbts_scores_on_cbt_user_cohort'
    
    # Drop and recreate the table with the correct types
    drop_table :cla_cbts_scores
    
    create_table :cla_cbts_scores do |t|
      t.references :cla_cbt, type: :uuid, null: true, foreign_key: false
      t.references :cla_user, type: :string, null: true, foreign_key: false
      t.references :cla_cohort, type: :integer, null: true, foreign_key: false
      t.references :cla_course, type: :uuid, null: true, foreign_key: false
      t.integer :score, null: true, default: 0

      t.timestamps
    end

    # Ensure uniqueness of cbt_id, user_id and cohort_id pair
    add_index :cla_cbts_scores, [:cla_cbt_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_cbts_scores_on_cbt_user_cohort'
  end

  def down
    remove_index :cla_cbts_scores, name: 'index_cla_cbts_scores_on_cbt_user_cohort'
    drop_table :cla_cbts_scores
  end
end
