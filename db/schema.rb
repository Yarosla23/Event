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

ActiveRecord::Schema[7.0].define(version: 2025_02_06_183843) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_photos", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_photos_on_event_id"
  end

  create_table "event_rules", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "rules"
    t.boolean "consent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_rules_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "event_type"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "location"
    t.string "location_link"
    t.string "event_format"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.text "tags", default: [], array: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.boolean "wifi", default: false
    t.boolean "air_conditioning", default: false
    t.boolean "audio_visual_equipment", default: false
    t.boolean "parking", default: false
    t.boolean "disabled_access", default: false
    t.boolean "kitchen", default: false
    t.integer "toilets_count", default: 0
    t.text "other_facilities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_facilities_on_venue_id"
  end

  create_table "information", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.text "document"
    t.text "description"
    t.boolean "smoking_allowed"
    t.boolean "alcohol_allowed"
    t.boolean "noise_restrictions"
    t.string "calendar"
    t.text "event_types", default: [], array: true
    t.text "restrictions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_information_on_venue_id"
  end

  create_table "logistics", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.text "organizers"
    t.text "contact_info"
    t.text "technical_requirements"
    t.text "special_instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_logistics_on_event_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.integer "min_participants"
    t.integer "max_participants"
    t.string "participant_type"
    t.boolean "is_private"
    t.boolean "is_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participants_on_event_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "middle_name"
    t.date "birthday_date"
    t.string "phone", null: false
    t.string "avatar"
    t.string "gender", null: false
    t.string "city"
    t.text "options"
    t.boolean "is_active", default: true
    t.jsonb "social_media_links", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cover_color", default: "#4f46e5"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "rental_infos", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.decimal "price", null: false
    t.text "discounts"
    t.integer "min_rental_duration_hours", default: 0
    t.text "payment_terms"
    t.time "working_hours_start", null: false
    t.time "working_hours_end", null: false
    t.text "rules"
    t.text "disclaimer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_rental_infos_on_venue_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reviews_on_user_id"
    t.index ["venue_id"], name: "index_reviews_on_venue_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.boolean "technical_equipment", default: false
    t.boolean "furniture", default: false
    t.boolean "decoration", default: false
    t.boolean "cleaning_after_event", default: false
    t.boolean "security", default: false
    t.text "additional_services"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_services_on_venue_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "ticket_type"
    t.decimal "price"
    t.string "currency"
    t.string "payment_method", default: [], array: true
    t.string "discount_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name", null: false
    t.text "venue_type", default: [], array: true
    t.text "description"
    t.string "address", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "website"
    t.integer "area", null: false
    t.integer "max_participants", null: false
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_venues_on_user_id"
  end

  add_foreign_key "event_photos", "events"
  add_foreign_key "event_rules", "events"
  add_foreign_key "events", "users"
  add_foreign_key "facilities", "venues"
  add_foreign_key "information", "venues"
  add_foreign_key "logistics", "events"
  add_foreign_key "participants", "events"
  add_foreign_key "rental_infos", "venues"
  add_foreign_key "reviews", "users"
  add_foreign_key "reviews", "venues"
  add_foreign_key "services", "venues"
  add_foreign_key "tickets", "events"
  add_foreign_key "venues", "users"
end
