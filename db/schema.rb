# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170124161205) do

  create_table "dispensations", primary_key: "dispensation_id", force: :cascade do |t|
    t.integer  "rx_id",             limit: 4
    t.string   "inventory_id",      limit: 255
    t.integer  "patient_id",        limit: 4
    t.integer  "quantity",          limit: 4
    t.datetime "dispensation_date"
    t.integer  "dispensed_by",      limit: 4
    t.boolean  "voided",            limit: 1,   default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "drug_categories", primary_key: "drug_category_id", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.boolean  "voided",     limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "drug_thresholds", primary_key: "threshold_id", force: :cascade do |t|
    t.string   "drug_id",    limit: 255
    t.integer  "threshold",  limit: 4
    t.boolean  "voided",     limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "drugs", primary_key: "drug_id", force: :cascade do |t|
    t.integer  "drug_category_id", limit: 4
    t.string   "name",             limit: 255
    t.string   "dose_strength",    limit: 255
    t.string   "dose_form",        limit: 255,                 null: false
    t.boolean  "voided",           limit: 1,   default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "general_inventories", primary_key: "gn_inventory_id", force: :cascade do |t|
    t.integer  "drug_id",           limit: 4
    t.string   "gn_identifier",     limit: 255
    t.date     "expiration_date"
    t.date     "date_received"
    t.integer  "received_quantity", limit: 4,   default: 0
    t.integer  "current_quantity",  limit: 4,   default: 0
    t.integer  "created_by",        limit: 4
    t.boolean  "voided",            limit: 1,   default: false
    t.string   "void_reason",       limit: 255
    t.integer  "voided_by",         limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "mobile_visit_products", primary_key: "mvp_id", force: :cascade do |t|
    t.integer  "mobile_visit_id", limit: 4
    t.string   "gn_identifier",   limit: 255
    t.integer  "amount_taken",    limit: 4
    t.integer  "amount_used",     limit: 4
    t.boolean  "voided",          limit: 1,   default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "mobile_visits", primary_key: "mobile_visit_id", force: :cascade do |t|
    t.date     "visit_date"
    t.integer  "visit_supervisor", limit: 4
    t.boolean  "voided",           limit: 1, default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "patients", primary_key: "patient_id", force: :cascade do |t|
    t.string   "patient_identifier",    limit: 255
    t.string   "first_name",            limit: 255
    t.string   "middle_name",           limit: 255
    t.string   "fathers_name",          limit: 255
    t.string   "mothers_name",          limit: 255
    t.string   "fname_namecode",        limit: 255
    t.string   "mname_namecode",        limit: 255
    t.string   "fathers_name_namecode", limit: 255
    t.string   "mothers_name_namecode", limit: 255
    t.string   "gender",                limit: 255
    t.date     "birthdate"
    t.boolean  "birthdate_estimated",   limit: 1,   default: false
    t.string   "marital_status",        limit: 255
    t.string   "occupation",            limit: 255
    t.string   "national_id",           limit: 255
    t.string   "region_of_birth",       limit: 255
    t.string   "province_of_birth",     limit: 255
    t.string   "region_of_residence",   limit: 255
    t.string   "province_of_residence", limit: 255
    t.string   "barrio_of_residence",   limit: 255
    t.integer  "creator",               limit: 4
    t.date     "date_voided"
    t.boolean  "voided",                limit: 1,   default: false
    t.integer  "voided_by",             limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "prescriptions", primary_key: "rx_id", force: :cascade do |t|
    t.integer  "patient_id",       limit: 4
    t.integer  "drug_id",          limit: 4
    t.datetime "date_prescribed"
    t.integer  "quantity",         limit: 4
    t.integer  "amount_dispensed", limit: 4
    t.string   "directions",       limit: 255
    t.integer  "provider_id",      limit: 4
    t.boolean  "voided",           limit: 1,   default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "first_name",   limit: 255
    t.string   "middle_name",  limit: 255
    t.string   "fathers_name", limit: 255
    t.string   "mothers_name", limit: 255
    t.string   "role",         limit: 255
    t.string   "password",     limit: 255
    t.string   "salt",         limit: 255
    t.string   "language",     limit: 255, default: "ESP"
    t.boolean  "voided",       limit: 1,   default: false
    t.integer  "voided_by",    limit: 4
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

end
