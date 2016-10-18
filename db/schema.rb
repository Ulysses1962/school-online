# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161011130637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "marks", force: :cascade do |t|
    t.integer  "student_id",      null: false
    t.integer  "subject_id",      null: false
    t.integer  "thematicplan_id"
    t.decimal  "mark",            null: false
    t.integer  "mark_type",       null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["student_id"], name: "index_marks_on_student_id", using: :btree
    t.index ["subject_id"], name: "index_marks_on_subject_id", using: :btree
    t.index ["thematicplan_id"], name: "index_marks_on_thematicplan_id", using: :btree
  end

  create_table "phones", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "phone_num"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_phones_on_profile_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name",         null: false
    t.string   "last_name",          null: false
    t.datetime "birth_date",         null: false
    t.integer  "academic_class"
    t.string   "academic_parallel"
    t.integer  "academic_group"
    t.string   "parent_name"
    t.string   "address_string"
    t.string   "personal_file_code", null: false
    t.string   "personal_tax_code",  null: false
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["academic_class"], name: "index_profiles_on_academic_class", using: :btree
    t.index ["academic_parallel"], name: "index_profiles_on_academic_parallel", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "ranks", force: :cascade do |t|
    t.integer  "student_id", null: false
    t.integer  "subject_id"
    t.integer  "rank_type"
    t.integer  "rank_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_ranks_on_student_id", using: :btree
    t.index ["subject_id"], name: "index_ranks_on_subject_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "rolename",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
    t.index ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree
  end

  create_table "schools", force: :cascade do |t|
    t.string   "school_code",           null: false
    t.string   "school_name",           null: false
    t.string   "school_email",          null: false
    t.string   "school_address_string", null: false
    t.string   "school_phone",          null: false
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_subjects_on_school_id", using: :btree
  end

  create_table "tariffications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.integer  "academic_year",     null: false
    t.integer  "academic_class",    null: false
    t.string   "academic_parallel", null: false
    t.integer  "academic_group"
    t.decimal  "tariff_hours",      null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["academic_class"], name: "index_tariffications_on_academic_class", using: :btree
    t.index ["academic_parallel"], name: "index_tariffications_on_academic_parallel", using: :btree
    t.index ["academic_year"], name: "index_tariffications_on_academic_year", using: :btree
    t.index ["subject"], name: "index_tariffications_on_subject", using: :btree
    t.index ["user_id"], name: "index_tariffications_on_user_id", using: :btree
  end

  create_table "thematic_plans", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "subject_id"
    t.integer  "academic_class",    null: false
    t.string   "academic_parallel", null: false
    t.string   "theme_name"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["academic_class"], name: "index_thematic_plans_on_academic_class", using: :btree
    t.index ["school_id"], name: "index_thematic_plans_on_school_id", using: :btree
    t.index ["subject_id"], name: "index_thematic_plans_on_subject_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "username",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "school_id",                           null: false
    t.string   "type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["school_id"], name: "index_users_on_school_id", using: :btree
  end

end
