# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_250_202_132_702) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'cla_roles', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['name'], name: 'index_cla_roles_on_name', unique: true
  end

  create_table 'cla_users', primary_key: 'user_id', id: :string, force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.bigint 'cla_cohort_id'
    t.bigint 'cla_role_id', null: false
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cla_cohort_id'], name: 'index_cla_users_on_cla_cohort_id'
    t.index ['cla_role_id'], name: 'index_cla_users_on_cla_role_id'
    t.index ['email'], name: 'index_cla_users_on_email', unique: true
  end

  add_foreign_key 'cla_users', 'cla_roles'
end
