class CreateClaSubmissions < ActiveRecord::Migration[7.1]
  def up
    # Enable the UUID extension if using PostgreSQL
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :cla_submissions, id: :uuid do |t|
      t.string :download_link, null: false
      t.datetime :date_submitted, null: false
      t.string :status, null: false, default: 'unmarked'
      t.integer :score, null: true 

      # Foreign keys
      t.references :cla_assignment_id, type: :uuid, null: true, foreign_key: false
      t.references :cla_student_id, type: :uuid, null: true, foreign_key: false

      t.timestamps
    end
  end

  def down
    drop_table :cla_submissions
  end
end
