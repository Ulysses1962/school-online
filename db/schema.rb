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

ActiveRecord::Schema.define(version: 20160709134538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_classes", force: :cascade do |t|
    t.integer  "school_id"
    t.string   "academic_year"
    t.integer  "academic_class_level"
    t.string   "academic_class_parallel"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["school_id"], name: "index_academic_classes_on_school_id", using: :btree
  end

  create_table "academic_groups", force: :cascade do |t|
    t.integer  "group_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "address_string"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["profile_id"], name: "index_addresses_on_profile_id", using: :btree
  end

  create_table "personal_files", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "personal_file_code", null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["profile_id"], name: "index_personal_files_on_profile_id", using: :btree
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
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.datetime "birth_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
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
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects_users", id: false, force: :cascade do |t|
    t.integer "subject_id", null: false
    t.integer "user_id",    null: false
    t.index ["subject_id", "user_id"], name: "index_subjects_users_on_subject_id_and_user_id", using: :btree
  end

  create_table "tariffications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "academic_class_id"
    t.integer  "academic_group_id"
    t.integer  "subject_id"
    t.integer  "academic_year"
    t.decimal  "tariff_hours"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["academic_class_id"], name: "index_tariffications_on_academic_class_id", using: :btree
    t.index ["academic_group_id"], name: "index_tariffications_on_academic_group_id", using: :btree
    t.index ["subject_id"], name: "index_tariffications_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_tariffications_on_user_id", using: :btree
  end

  create_table "tax_codes", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "ptc",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_tax_codes_on_profile_id", using: :btree
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
    t.integer  "academic_class_id"
    t.integer  "academic_group_id"
    t.integer  "parent_name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["school_id"], name: "index_users_on_school_id", using: :btree
  end

end
