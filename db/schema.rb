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

ActiveRecord::Schema.define(version: 2019_01_02_004617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "average_caches", force: :cascade do |t|
    t.bigint "rater_id"
    t.string "rateable_type"
    t.bigint "rateable_id"
    t.float "avg", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_type", "rateable_id"], name: "index_average_caches_on_rateable_type_and_rateable_id"
    t.index ["rater_id"], name: "index_average_caches_on_rater_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "make", null: false
    t.string "model", null: false
    t.integer "year", null: false
    t.string "vehicle_type", null: false
    t.string "fuel_type", null: false
    t.integer "cubic_capacity", null: false
    t.string "transmission", null: false
    t.integer "purchase_date", null: false
    t.integer "mileage", default: 0
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "operations", force: :cascade do |t|
    t.bigint "car_id"
    t.bigint "organization_id"
    t.bigint "service_id"
    t.decimal "price", precision: 8, scale: 3
    t.integer "current_mileage", null: false
    t.integer "next_mileage"
    t.boolean "state", default: true
    t.datetime "next_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_operations_on_car_id"
    t.index ["organization_id"], name: "index_operations_on_organization_id"
    t.index ["service_id"], name: "index_operations_on_service_id"
  end

  create_table "organization_addresses", force: :cascade do |t|
    t.string "city", null: false
    t.string "street", null: false
    t.string "house_number", null: false
    t.string "phone", limit: 15, null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_addresses_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "phone", limit: 15, null: false
    t.bigint "service_type_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "aasm_state"
    t.index ["deleted_at"], name: "index_organizations_on_deleted_at"
    t.index ["service_type_id"], name: "index_organizations_on_service_type_id"
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "overall_averages", force: :cascade do |t|
    t.string "rateable_type"
    t.bigint "rateable_id"
    t.float "overall_avg", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_type", "rateable_id"], name: "index_overall_averages_on_rateable_type_and_rateable_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "image"
    t.string "firstname", null: false
    t.string "surname", null: false
    t.string "nickname", null: false
    t.date "birthday"
    t.string "address", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.bigint "rater_id"
    t.string "rateable_type"
    t.bigint "rateable_id"
    t.float "stars", null: false
    t.string "dimension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
    t.index ["rateable_type", "rateable_id"], name: "index_rates_on_rateable_type_and_rateable_id"
    t.index ["rater_id"], name: "by_rates"
    t.index ["rater_id"], name: "index_rates_on_rater_id"
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string "cacheable_type"
    t.bigint "cacheable_id"
    t.float "avg", null: false
    t.integer "qty", null: false
    t.string "dimension"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"
    t.index ["cacheable_type", "cacheable_id"], name: "index_rating_caches_on_cacheable_type_and_cacheable_id"
  end

  create_table "service_for_organizations", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "service_id"], name: "uniq_service_for_organization", unique: true
    t.index ["organization_id"], name: "index_service_for_organizations_on_organization_id"
    t.index ["service_id"], name: "index_service_for_organizations_on_service_id"
  end

  create_table "service_types", force: :cascade do |t|
    t.string "type_en", null: false
    t.string "type_ru", null: false
    t.string "type_es"
  end

  create_table "services", force: :cascade do |t|
    t.string "name_en"
    t.string "name_ru"
    t.string "name_es"
    t.bigint "service_type_id"
    t.index ["service_type_id"], name: "index_services_on_service_type_id"
  end

  create_table "type_cars", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.integer "role"
    t.string "locale", default: "en"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "service_for_organizations", "organizations"
  add_foreign_key "service_for_organizations", "services"
end
