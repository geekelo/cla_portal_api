class CreateClaAssignments < ActiveRecord::Migration[7.1]
  def up
    # Enable the UUID extension if using PostgreSQL
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :cla_assignments, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false

      # Foreign keys
      t.references :cla_course, type: :uuid, null: false, foreign_key: false
      t.references :cla_user, type: :uuid, null: false, foreign_key: false

      t.timestamps
    end

    # Add any additional indexes if necessary
  end

  def down
    drop_table :cla_assignments
  end
end
