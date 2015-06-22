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

ActiveRecord::Schema.define(version: 20150312092837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "as", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "to_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "ddn_id"
  end

  add_index "as", ["name", "to_ip"], name: "index_as_on_name_and_to_ip", unique: true, using: :btree

  create_table "cnames", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "to_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cnames", ["name", "to_name"], name: "index_cnames_on_name_and_to_name", unique: true, using: :btree

  create_table "ddns", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "device_name"
    t.string   "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "ddns", ["device_name"], name: "index_ddns_on_device_name", unique: true, using: :btree
  add_index "ddns", ["token"], name: "index_ddns_on_token", unique: true, using: :btree

  create_table "domains", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  add_index "domains", ["name"], name: "index_domains_on_name", unique: true, using: :btree
  add_index "domains", ["slug"], name: "index_domains_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "mxes", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.integer  "priority"
    t.string   "to_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "mxes", ["name", "priority", "to_name"], name: "index_mxes_on_name_and_priority_and_to_name", unique: true, using: :btree

  create_table "nameservers", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "to_ns"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "nameservers", ["name", "to_ns"], name: "index_nameservers_on_name_and_to_ns", unique: true, using: :btree

  create_table "ptrs", force: :cascade do |t|
    t.string   "ip_arpa"
    t.string   "to_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "a_id"
  end

  create_table "soas", force: :cascade do |t|
    t.integer  "domain_id"
    t.string   "name"
    t.string   "contact"
    t.integer  "serial"
    t.integer  "refresh"
    t.integer  "retry"
    t.integer  "expire"
    t.integer  "minimum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "soas", ["domain_id"], name: "index_soas_on_domain_id", unique: true, using: :btree

  create_table "user_domain_maps", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_domain_maps", ["domain_id", "user_id"], name: "index_user_domain_maps_on_domain_id_and_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
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
    t.string   "username"
    t.boolean  "admin",                  default: false
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
