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

ActiveRecord::Schema.define(version: 20140521234553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "dblink"
  enable_extension "hstore"

  create_table "batches", force: true do |t|
    t.date "created_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "info"
    t.datetime "project_created_at"
    t.datetime "start_page_viewed_at"
    t.integer  "batch_id"
  end

  add_index "contacts", ["batch_id"], name: "index_contacts_on_batch_id", using: :btree

  create_table "emails", force: true do |t|
    t.integer  "contact_id"
    t.string   "method"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "version"
    t.datetime "opened"
    t.datetime "replied_at"
  end

  add_index "emails", ["contact_id"], name: "index_emails_on_contact_id", using: :btree

  create_table "outbound_processes", force: true do |t|
    t.integer  "contact_id"
    t.string   "workflow_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "workflow_state_timestamps", default: {}
  end

  add_index "outbound_processes", ["contact_id"], name: "index_outbound_processes_on_contact_id", using: :btree

end
