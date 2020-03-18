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

ActiveRecord::Schema.define(version: 2020_03_18_091234) do

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

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "phone_number"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "assets", "users"
  add_foreign_key "ratings", "assets"
end
