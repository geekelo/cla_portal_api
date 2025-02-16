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

ActiveRecord::Schema[7.1].define(version: 2025_02_16_125442) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "cla_assignments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.uuid "cla_course_id", null: false
    t.string "cla_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "due_date"
    t.boolean "submitted", default: false
    t.index ["cla_course_id"], name: "index_cla_assignments_on_cla_course_id"
    t.index ["cla_user_id"], name: "index_cla_assignments_on_cla_user_id"
  end

  create_table "cla_attendances", force: :cascade do |t|
    t.bigint "cla_live_class_id"
    t.bigint "cla_user_id"
    t.bigint "cla_cohort_id"
    t.boolean "present", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cla_cohort_id"], name: "index_cla_attendances_on_cla_cohort_id"
    t.index ["cla_live_class_id", "cla_user_id"], name: "index_cla_attendances_on_cla_live_class_id_and_cla_user_id", unique: true
    t.index ["cla_live_class_id"], name: "index_cla_attendances_on_cla_live_class_id"
    t.index ["cla_user_id"], name: "index_cla_attendances_on_cla_user_id"
  end

  create_table "cla_cohorts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "cla_course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.index ["cla_course_id"], name: "index_cla_cohorts_on_cla_course_id"
    t.index ["name"], name: "index_cla_cohorts_on_name", unique: true
  end

  create_table "cla_courses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.uuid "topic_id"
    t.uuid "assignment_id"
    t.uuid "live_class_id"
    t.bigint "cla_cohort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
    t.boolean "locked", default: false
    t.string "cla_user_id", default: "", null: false
    t.index ["assignment_id"], name: "index_cla_courses_on_assignment_id"
    t.index ["cla_cohort_id"], name: "index_cla_courses_on_cla_cohort_id"
    t.index ["cla_user_id"], name: "index_cla_courses_on_cla_user_id"
    t.index ["live_class_id"], name: "index_cla_courses_on_live_class_id"
    t.index ["name"], name: "index_cla_courses_on_name", unique: true
    t.index ["topic_id"], name: "index_cla_courses_on_topic_id"
  end

  create_table "cla_live_classes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.date "date", null: false
    t.time "time", null: false
    t.string "duration", null: false
    t.string "zoom_link", null: false
    t.string "cla_course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cla_cohort_id", null: false
    t.string "cla_user_id", default: "", null: false
    t.index ["cla_cohort_id"], name: "index_cla_live_classes_on_cla_cohort_id"
    t.index ["cla_course_id"], name: "index_cla_live_classes_on_cla_course_id"
    t.index ["cla_user_id"], name: "index_cla_live_classes_on_cla_user_id"
  end

  create_table "cla_roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cla_roles_on_name", unique: true
  end

  create_table "cla_submissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "download_link", null: false
    t.string "status", default: "unmarked"
    t.integer "score"
    t.string "cla_assignment_id"
    t.string "cla_student_id"
    t.string "cla_facilitator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cla_assignment_id"], name: "index_cla_submissions_on_cla_assignment_id"
    t.index ["cla_facilitator_id"], name: "index_cla_submissions_on_cla_facilitator_id"
    t.index ["cla_student_id"], name: "index_cla_submissions_on_cla_student_id"
  end

  create_table "cla_topics", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.uuid "cla_course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cla_course_id"], name: "index_cla_topics_on_cla_course_id"
    t.index ["name", "cla_course_id"], name: "index_cla_topics_on_name_and_cla_course_id", unique: true
  end

  create_table "cla_users", primary_key: "user_id", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.bigint "cla_cohort_id"
    t.bigint "cla_role_id"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "birthday"
    t.string "id"
    t.index ["cla_cohort_id"], name: "index_cla_users_on_cla_cohort_id"
    t.index ["cla_role_id"], name: "index_cla_users_on_cla_role_id"
    t.index ["email"], name: "index_cla_users_on_email", unique: true
  end

  add_foreign_key "cla_users", "cla_roles"
end
