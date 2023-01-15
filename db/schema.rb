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

  create_table "events", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.uuid "uuid", null: false
    t.integer "category", null: false
    t.string "display_name", null: false
    t.string "description", null: false
    t.date "date", null: false
    t.datetime "from", null: false
    t.datetime "to"
    t.datetime "discarded_at"
    t.datetime "expires_at"
    t.string "location_link"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "kaha_profiles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.uuid "uuid", null: false
    t.integer "goals"
    t.integer "appearances"
    t.integer "position"
    t.integer "rank"
    t.integer "priority"
    t.integer "booking_preference"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.uuid "uuid", null: false
    t.integer "role", null: false
    t.integer "gender"
    t.bigint "hakos"
    t.string "phone", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
