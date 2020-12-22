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

ActiveRecord::Schema.define(version: 2020_12_22_082521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "event_languages", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "language_id"
    t.integer "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "language_id"], name: "index_event_languages_on_event_id_and_language_id", unique: true
    t.index ["event_id"], name: "index_event_languages_on_event_id"
    t.index ["language_id"], name: "index_event_languages_on_language_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "schedule", null: false
    t.bigint "organizer_id"
    t.bigint "group_id"
    t.text "content", null: false
    t.boolean "online", default: false
    t.boolean "permission", default: false
    t.boolean "guest_allowed", default: false
    t.string "address", limit: 255, default: ""
    t.float "lat"
    t.float "lon"
    t.string "place", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["content"], name: "index_events_on_content"
    t.index ["group_id"], name: "index_events_on_group_id"
    t.index ["name"], name: "index_events_on_name"
    t.index ["organizer_id"], name: "index_events_on_organizer_id"
    t.index ["schedule"], name: "index_events_on_schedule"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "detail", default: ""
    t.boolean "permission", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id"
    t.index ["owner_id"], name: "index_groups_on_owner_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code"
    t.string "en_name"
    t.string "ja_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.boolean "pending", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_members_on_group_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_organizers_on_group_id"
    t.index ["user_id"], name: "index_organizers_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.boolean "pending"
    t.boolean "guest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.bigint "event_language_id"
    t.index ["event_id"], name: "index_participants_on_event_id"
    t.index ["event_language_id"], name: "index_participants_on_event_language_id"
    t.index ["group_id"], name: "index_participants_on_group_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "translations", force: :cascade do |t|
    t.bigint "events_id"
    t.text "content"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["events_id"], name: "index_translations_on_events_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name", limit: 255, null: false
    t.text "introduction", default: ""
    t.string "address", limit: 255, default: ""
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "event_languages", "events"
  add_foreign_key "event_languages", "languages"
  add_foreign_key "events", "groups"
  add_foreign_key "events", "organizers"
  add_foreign_key "events", "users"
  add_foreign_key "groups", "users", column: "owner_id"
  add_foreign_key "members", "groups"
  add_foreign_key "members", "users"
  add_foreign_key "organizers", "groups"
  add_foreign_key "organizers", "users"
  add_foreign_key "participants", "event_languages"
  add_foreign_key "participants", "events"
  add_foreign_key "participants", "groups"
  add_foreign_key "participants", "users"
  add_foreign_key "translations", "events", column: "events_id"
end
