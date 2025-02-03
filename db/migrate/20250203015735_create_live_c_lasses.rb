class CreateLiveCLasses < ActiveRecord::Migration[7.1]
  def up
    # Enable the UUID extension if using PostgreSQL
    enable_extension 'uuid-ossp' unless extension_enabled?('uuid-ossp')

    create_table :cla_live_classes, id: :uuid do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.time :time, null: false
      t.string :duration, null: false
      t.string :zoom_link, null: false

      # Foreign keys
      t.references :cla_course, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :cla_live_classes
  end
end
