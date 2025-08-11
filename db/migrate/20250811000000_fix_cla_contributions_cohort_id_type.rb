class FixClaContributionsCohortIdType < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing index first
    remove_index :cla_contributions, name: 'index_cla_contributions_on_course_user_cohort'
    
    # Change the column type from UUID to integer
    change_column :cla_contributions, :cla_cohort_id, :bigint, null: true
    
    # Recreate the index with the new column type
    add_index :cla_contributions, [:cla_course_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_contributions_on_course_user_cohort'
  end

  def down
    # Remove the index
    remove_index :cla_contributions, name: 'index_cla_contributions_on_course_user_cohort'
    
    # Change the column type back to UUID
    change_column :cla_contributions, :cla_cohort_id, :uuid, null: true
    
    # Recreate the index
    add_index :cla_contributions, [:cla_course_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_contributions_on_course_user_cohort'
  end
end 