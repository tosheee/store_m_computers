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

ActiveRecord::Schema.define(version: 20170414173350) do

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

  create_table "admin_product_features", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "sub_category_id"
    t.string   "identifier"
    t.text     "description"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "active",          default: true
  end

  add_index "admin_product_features", ["identifier"], name: "index_admin_product_features_on_identifier", using: :btree

  create_table "admin_products", force: :cascade do |t|
    t.integer  "category_id"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "admin_sales", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "full_name"
    t.string   "phone"
    t.string   "email"
    t.string   "domain"
    t.string   "city"
    t.text     "addres"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_sub_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "admin_sub_categories", ["identifier"], name: "index_admin_sub_categories_on_identifier", using: :btree
  add_index "admin_sub_categories", ["name"], name: "index_admin_sub_categories_on_name", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "admin_product_feature_id"
    t.integer  "order_id"
    t.decimal  "unit_price",               precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price",              precision: 12, scale: 3
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "order_items", ["admin_product_feature_id"], name: "index_order_items_on_admin_product_feature_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",        precision: 12, scale: 3
    t.decimal  "tax",             precision: 12, scale: 3
    t.decimal  "shipping",        precision: 12, scale: 3
    t.decimal  "total",           precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

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

  add_foreign_key "order_items", "admin_product_features", on_delete: :cascade
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "order_statuses"
end
