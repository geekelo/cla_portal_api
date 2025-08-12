class FixClaCbtsCohortIdType < ActiveRecord::Migration[7.1]
  def up
    # Remove the existing index first
    remove_index :cla_cbts, name: 'index_cla_cbts_on_course_user_cohort'
    
    # Drop and recreate the column with the correct type
    remove_column :cla_cbts, :cla_cohort_id
    add_column :cla_cbts, :cla_cohort_id, :integer, null: true
    
    # Recreate the index with the new column type
    add_index :cla_cbts, [:cla_course_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_cbts_on_course_user_cohort'
  end

  def down
    # Remove the index
    remove_index :cla_cbts, name: 'index_cla_cbts_on_course_user_cohort'
    
    # Drop and recreate the column with UUID type
    remove_column :cla_cbts, :cla_cohort_id
    add_column :cla_cbts, :cla_cohort_id, :uuid, null: true
    
    # Recreate the index
    add_index :cla_cbts, [:cla_course_id, :cla_user_id, :cla_cohort_id], unique: true, name: 'index_cla_cbts_on_course_user_cohort'
  end
end
