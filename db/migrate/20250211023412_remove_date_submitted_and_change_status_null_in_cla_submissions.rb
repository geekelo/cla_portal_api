class RemoveDateSubmittedAndChangeStatusNullInClaSubmissions < ActiveRecord::Migration[7.1]
  def up
    # Remove the date_submitted column
    remove_column :cla_submissions, :date_submitted, :datetime

    # Change the status column to allow NULL values
    change_column_null :cla_submissions, :status, true
  end

  def down
    # Add the date_submitted column back (as non-nullable)
    add_column :cla_submissions, :date_submitted, :datetime, null: false

    # Revert the status column to disallow NULL values
    change_column_null :cla_submissions, :status, false
  end
end
