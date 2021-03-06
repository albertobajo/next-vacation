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

ActiveRecord::Schema.define(version: 2019_11_13_200724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "minutes_spent"
    t.geometry "lonlat", limit: {:srid=>0, :type=>"st_point"}
    t.bigint "category_id", null: false
    t.bigint "district_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_activities_on_category_id"
    t.index ["district_id"], name: "index_activities_on_district_id"
    t.index ["location_id"], name: "index_activities_on_location_id"
    t.index ["lonlat"], name: "index_activities_on_lonlat", using: :gist
    t.index ["name"], name: "index_activities_on_name"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_districts_on_city_id"
    t.index ["name"], name: "index_districts_on_name"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "day_of_week"
    t.integer "opens_at"
    t.integer "closes_at"
    t.bigint "activity_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "first_exit_at"
    t.integer "last_entry_at"
    t.index ["activity_id"], name: "index_opening_hours_on_activity_id"
    t.index ["closes_at"], name: "index_opening_hours_on_closes_at"
    t.index ["day_of_week"], name: "index_opening_hours_on_day_of_week"
    t.index ["first_exit_at"], name: "index_opening_hours_on_first_exit_at"
    t.index ["last_entry_at"], name: "index_opening_hours_on_last_entry_at"
    t.index ["opens_at"], name: "index_opening_hours_on_opens_at"
  end

  add_foreign_key "activities", "categories"
  add_foreign_key "activities", "districts"
  add_foreign_key "activities", "locations"
  add_foreign_key "districts", "cities"
  add_foreign_key "opening_hours", "activities"
end
