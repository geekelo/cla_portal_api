class AddStartAndEndDateToClaCohorts < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_cohorts, :start_date, :date, null: true
    add_column :cla_cohorts, :end_date, :date, null: true
  end

  def down
    remove_column :cla_cohorts, :start_date
    remove_column :cla_cohorts, :end_date
  end
end
