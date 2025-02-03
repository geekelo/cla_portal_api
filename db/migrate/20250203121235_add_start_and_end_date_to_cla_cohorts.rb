class AddStartAndEndDateToClaCohorts < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_cohorts, :start_date, :date, null: false
    add_column :cla_cohorts, :end_date, :date, null: false
  end

  def down
    remove_column :cla_cohorts, :start_date
    remove_column :cla_cohorts, :end_date
  end
end
