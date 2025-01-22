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

ActiveRecord::Schema[7.0].define(version: 2025_01_22_190210) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_amenities_on_venue_id"
  end

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

  create_table "event_types", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_event_types_on_venue_id"
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
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "tags"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "policies", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.boolean "smoking_allowed"
    t.boolean "alcohol_allowed"
    t.boolean "noise_restrictions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_policies_on_venue_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.decimal "amount"
    t.string "currency"
    t.integer "min_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_prices_on_venue_id"
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

  create_table "reviews", force: :cascade do |t|
    t.bigint "venue_id", null: false
    t.text "content"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_reviews_on_venue_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_taggings_on_event_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "venue_type"
    t.text "description"
    t.string "address"
    t.string "city"
    t.string "district"
    t.string "phone"
    t.string "email"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "amenities", "venues"
  add_foreign_key "event_photos", "events"
  add_foreign_key "event_rules", "events"
  add_foreign_key "event_types", "venues"
  add_foreign_key "events", "users"
  add_foreign_key "logistics", "events"
  add_foreign_key "participants", "events"
  add_foreign_key "policies", "venues"
  add_foreign_key "prices", "venues"
  add_foreign_key "reviews", "venues"
  add_foreign_key "taggings", "events"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tickets", "events"
end
