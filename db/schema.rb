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

ActiveRecord::Schema.define(version: 20170216103111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_categories", force: :cascade do |t|
    t.string   "name_cat"
    t.integer  "view_cat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_extract_xmls", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_laptops", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "code"
    t.string   "name"
    t.string   "product_status"
    t.string   "hashpromo"
    t.string   "general_description"
    t.string   "classname"
    t.string   "price"
    t.string   "currency"
    t.text     "main_picture_url"
    t.string   "manufacturer"
    t.string   "category"
    t.string   "partnum"
    t.text     "gallery"
    t.string   "vendor_url"
    t.string   "property_manufacturer"
    t.string   "property_mnfr_part"
    t.string   "property_model"
    t.string   "property_screen_size"
    t.string   "property_screen_type"
    t.string   "property_screen_resolution"
    t.string   "property_memory_size"
    t.string   "property_memory_type"
    t.string   "property_cpu"
    t.string   "model"
    t.string   "property_graphics"
    t.string   "property_hdd"
    t.string   "property_ssd"
    t.string   "property_disk_specifications"
    t.string   "property_interface"
    t.string   "property_camera"
    t.string   "property_odd"
    t.string   "property_os"
    t.string   "property_wi_fi"
    t.string   "property_audio"
    t.string   "property_lan"
    t.string   "property_bluetooth"
    t.string   "property_body_color"
    t.string   "property_battery"
    t.string   "property_dimensions"
    t.string   "property_weight"
    t.string   "property_other"
    t.string   "property_warranty"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "admin_notebooks", force: :cascade do |t|
    t.integer  "category_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "admin_products", force: :cascade do |t|
    t.integer  "category_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "phone"
    t.string   "role",                   default: "client"
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
