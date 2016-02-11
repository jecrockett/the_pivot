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

ActiveRecord::Schema.define(version: 20160210224759) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "causes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.integer  "goal"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "other_admins",   default: [],                     array: true
    t.string   "current_status", default: "pending"
  end

  add_index "causes", ["category_id"], name: "index_causes_on_category_id", using: :btree
  add_index "causes", ["user_id"], name: "index_causes_on_user_id", using: :btree

  create_table "causes_users", force: :cascade do |t|
    t.integer "cause_id"
    t.integer "user_id"
    t.integer "role"
  end

  add_index "causes_users", ["cause_id"], name: "index_causes_users_on_cause_id", using: :btree
  add_index "causes_users", ["user_id"], name: "index_causes_users_on_user_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cause_id"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "cause_name"
    t.string   "stripe_token"
  end

  add_index "donations", ["cause_id"], name: "index_donations_on_cause_id", using: :btree
  add_index "donations", ["user_id"], name: "index_donations_on_user_id", using: :btree

  create_table "ownership", force: :cascade do |t|
    t.integer "cause_id"
    t.integer "user_id"
    t.integer "role",     default: 0
  end

  add_index "ownership", ["cause_id"], name: "index_ownership_on_cause_id", using: :btree
  add_index "ownership", ["user_id"], name: "index_ownership_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.integer  "role",               default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
  end

  add_foreign_key "causes", "categories"
  add_foreign_key "causes", "users"
  add_foreign_key "causes_users", "causes"
  add_foreign_key "causes_users", "users"
  add_foreign_key "donations", "causes"
  add_foreign_key "donations", "users"
  add_foreign_key "ownership", "causes"
  add_foreign_key "ownership", "users"
end
