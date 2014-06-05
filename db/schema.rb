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

ActiveRecord::Schema.define(version: 20140605184420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.string   "name"
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "songkick_id"
  end

  create_table "artists_performances", id: false, force: true do |t|
    t.integer "performance_id", null: false
    t.integer "artist_id",      null: false
  end

  create_table "owners", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "owners", ["email"], name: "index_owners_on_email", unique: true, using: :btree
  add_index "owners", ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true, using: :btree

  create_table "performances", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.time     "time"
    t.string   "description"
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "songkick_id"
  end

  add_index "performances", ["venue_id"], name: "index_performances_on_venue_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "street_address_1"
    t.string   "street_address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "website"
    t.string   "phone"
    t.string   "ticket_link"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "songkick_id"
    t.float    "lat"
    t.float    "lng"
  end

  add_index "venues", ["owner_id"], name: "index_venues_on_owner_id", using: :btree

end
