# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_18_124351) do

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "payment_period"
    t.string "dimension"
    t.text "description"
    t.string "rentable_duration"
    t.string "event_tags"
    t.string "booking_type"
    t.boolean "available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_assets_on_user_id"
  end

  create_table "booked_assets", force: :cascade do |t|
    t.integer "asset_id"
    t.integer "booking_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_booked_assets_on_booking_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.text "cancelation_msg"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.integer "request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_events_on_request_id"
  end

  create_table "locations", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "place"
    t.string "city"
    t.string "address"
    t.integer "asset_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asset_id"], name: "index_locations_on_asset_id"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
    t.integer "request_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["request_id"], name: "index_notes_on_request_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.text "feedback"
    t.integer "user_id"
    t.integer "asset_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asset_id"], name: "index_ratings_on_asset_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer "user_id"
    t.string "request_status", default: "pending"
    t.integer "asset_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["asset_id"], name: "index_requests_on_asset_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "phone_number"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "wished_assets", force: :cascade do |t|
    t.integer "asset_id"
    t.integer "wishlist_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["wishlist_id"], name: "index_wished_assets_on_wishlist_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "assets", "users"
  add_foreign_key "booked_assets", "bookings"
  add_foreign_key "bookings", "users"
  add_foreign_key "events", "requests"
  add_foreign_key "locations", "assets"
  add_foreign_key "notes", "requests"
  add_foreign_key "ratings", "assets"
  add_foreign_key "requests", "assets"
  add_foreign_key "wished_assets", "wishlists"
  add_foreign_key "wishlists", "users"
end
