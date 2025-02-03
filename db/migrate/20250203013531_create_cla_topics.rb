class CreateClaTopics < ActiveRecord::Migration[7.1]
  def up
    # Enable the UUID extension if using PostgreSQL
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :cla_topics, id: :uuid do |t|
      t.string :name, null: false
      t.text :description
      t.references :cla_course, type: :uuid, null: false, foreign_key: false, index: true

      t.timestamps
    end

    # Add unique constraint on the name column within the same course
    add_index :cla_topics, [:name, :cla_course_id], unique: true
  end

  def down
    drop_table :cla_topics
  end
end
