# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_01_145433) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "conversation_participants", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.index ["conversation_id"], name: "index_conversation_participants_on_conversation_id"
    t.index ["user_id"], name: "index_conversation_participants_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.string "source_id", null: false
    t.integer "conversation_type", default: 0, null: false
    t.string "display_name"
    t.datetime "last_message_at"
    t.datetime "first_message_at"
    t.datetime "discarded_at"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_conversations_on_created_by_id"
    t.index ["discarded_at"], name: "index_conversations_on_discarded_at"
    t.index ["source_id"], name: "index_conversations_on_source_id", unique: true
  end

  create_table "event_participants", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "participant_id"
    t.bigint "event_id"
  end

  create_table "events", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.integer "category", default: 0, null: false
    t.string "display_name", null: false
    t.string "description", null: false
    t.date "date", null: false
    t.datetime "from", null: false
    t.datetime "to"
    t.datetime "discarded_at"
    t.datetime "expires_at"
    t.datetime "canceled_at"
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "latitude", precision: 10, scale: 6
    t.bigint "created_by_id", null: false
    t.bigint "canceled_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["canceled_by_id"], name: "index_events_on_canceled_by_id"
    t.index ["created_by_id"], name: "index_events_on_created_by_id"
    t.index ["discarded_at"], name: "index_events_on_discarded_at"
  end

  create_table "kaha_profiles", force: :cascade do |t|
    t.integer "goals", default: 0
    t.integer "appearances", default: 0
    t.integer "position", default: 0
    t.integer "rank", default: 0
    t.integer "priority", default: 0
    t.integer "booking_preference", default: 0
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_kaha_profiles_on_player_id"
  end

  create_table "messages", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.string "source_id"
    t.integer "message_type", default: 0, null: false
    t.integer "message_subtype", default: 0, null: false
    t.integer "message_origin_type", default: 0, null: false
    t.string "source_reply_to_message_id"
    t.integer "source_forward_from_user_id"
    t.integer "source_forward_from_conversation_id"
    t.string "source_forward_from_message_id"
    t.boolean "replied_to", default: false
    t.boolean "forwarded", default: false
    t.jsonb "payload"
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.datetime "delivered_at"
    t.datetime "read_at"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id", "source_id"], name: "index_messages_on_conversation_id_and_source_id", unique: true
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.integer "role", default: 0, null: false
    t.integer "gender", default: 0
    t.bigint "hakos", default: 0
    t.string "display_name"
    t.string "ig_profile_link"
    t.integer "provider", default: 0
    t.string "uid"
    t.string "phone", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "email", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "jti", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "conversations", "users", column: "created_by_id"
  add_foreign_key "event_participants", "events"
  add_foreign_key "event_participants", "users", column: "participant_id"
  add_foreign_key "events", "users", column: "canceled_by_id"
  add_foreign_key "events", "users", column: "created_by_id"
  add_foreign_key "kaha_profiles", "users", column: "player_id"
end
