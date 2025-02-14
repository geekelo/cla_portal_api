class AddPhoneNumberAndBirthdayToClaUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :cla_users, :phone_number, :string, null: true
    add_column :cla_users, :birthday, :string, null: true # Storing birthday as "MM-DD" without the year
  end

  def down
    remove_column :cla_users, :phone_number
    remove_column :cla_users, :birthday
  end
end
