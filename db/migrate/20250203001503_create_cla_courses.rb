class CreateClaCourses < ActiveRecord::Migration[7.1]
  def up
    # Enable the UUID extension if using PostgreSQL
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :cla_courses, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false

      # Foreign keys without enforcing foreign key constraints but with indexing
      t.references :topic, type: :uuid, null: true, index: true
      t.references :assignment, type: :uuid, null: true, index: true
      t.references :live_class, type: :uuid, null: true, index: true
      t.references :cla_user, foreign_key: false, null: true, index: true
      t.references :cla_cohort, foreign_key: false, null: true, index: true

      t.timestamps
    end
        # Add unique constraint separately
        add_index :cla_courses, :name, unique: true
  end

  def down
    drop_table :cla_courses
  end
end
