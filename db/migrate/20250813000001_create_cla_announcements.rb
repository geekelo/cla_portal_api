class CreateClaAnnouncements < ActiveRecord::Migration[7.1]
  def change
    create_table :cla_announcements, id: :uuid do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :cla_cohort, type: :integer, null: true, foreign_key: false
      t.references :cla_user, type: :string, null: true, foreign_key: false

      t.timestamps
    end

    add_index :cla_announcements, :cla_cohort_id
    add_index :cla_announcements, :cla_user_id
  end
end
