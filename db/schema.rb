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

ActiveRecord::Schema.define(version: 20130907224609) do

  create_table "announcement_impressions", force: true do |t|
    t.integer  "customer_id",     null: false
    t.integer  "announcement_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcement_impressions", ["announcement_id"], name: "index_announcement_impressions_on_announcement_id"
  add_index "announcement_impressions", ["customer_id"], name: "index_announcement_impressions_on_customer_id"

  create_table "announcement_segments", force: true do |t|
    t.integer  "announcement_id",     null: false
    t.integer  "customer_segment_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcement_segments", ["announcement_id", "customer_segment_id"], name: "announcement_segment_unique", unique: true

  create_table "announcements", force: true do |t|
    t.string   "name",              null: false
    t.string   "description"
    t.boolean  "is_active",         null: false
    t.string   "trigger_page"
    t.string   "trigger_event"
    t.string   "content",           null: false
    t.string   "announcement_type", null: false
    t.string   "position"
    t.string   "color"
    t.boolean  "is_dismissable",    null: false
    t.datetime "active_until",      null: false
    t.integer  "user_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "announcements", ["name", "user_id"], name: "index_announcements_on_name_and_user_id", unique: true
  add_index "announcements", ["user_id"], name: "index_announcements_on_user_id"

  create_table "customer_segments", force: true do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_segments", ["name", "user_id"], name: "index_customer_segments_on_name_and_user_id", unique: true

  create_table "customers", force: true do |t|
    t.string   "customer_id", null: false
    t.string   "email"
    t.datetime "first_seen",  null: false
    t.datetime "last_seen",   null: false
    t.integer  "user_id",     null: false
  end

  add_index "customers", ["customer_id"], name: "index_customers_on_customer_id", unique: true
  add_index "customers", ["email"], name: "index_customers_on_email", unique: true

  create_table "event_properties", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_properties", ["event_id"], name: "index_event_properties_on_event_id"

  create_table "events", force: true do |t|
    t.string   "name",        null: false
    t.datetime "timestamp",   null: false
    t.integer  "customer_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["customer_id"], name: "index_events_on_customer_id"

  create_table "segment_memberships", force: true do |t|
    t.integer  "customer_segment_id", null: false
    t.integer  "customer_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "segment_memberships", ["customer_segment_id", "customer_id"], name: "segment_membership_unique", unique: true

  create_table "traits", force: true do |t|
    t.string   "key",         null: false
    t.string   "value",       null: false
    t.integer  "customer_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "traits", ["customer_id"], name: "index_traits_on_customer_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
