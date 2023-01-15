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

ActiveRecord::Schema[7.0].define(version: 2023_01_14_234310) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

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
    t.string "location_link"
    t.bigint "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_events_on_created_by_id"
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

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.integer "role", default: 0, null: false
    t.integer "gender", default: 0
    t.bigint "hakos", default: 0
    t.string "display_name", null: false
    t.string "ig_profile_link"
    t.string "phone", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "email", default: ""
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_participants", "events"
  add_foreign_key "event_participants", "users", column: "participant_id"
  add_foreign_key "events", "users", column: "created_by_id"
  add_foreign_key "kaha_profiles", "users", column: "player_id"
end
