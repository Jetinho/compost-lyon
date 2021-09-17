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

ActiveRecord::Schema.define(version: 2021_09_17_192402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_searches", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.bigint "ip"
    t.float "closest_site_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "website_url"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.text "description"
    t.bigint "user_id", default: 1, null: false
    t.string "contact_email"
    t.index ["user_id"], name: "index_organisations_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organisation_id", null: false
    t.string "city"
    t.string "address"
    t.string "zipcode"
    t.string "site_type"
    t.boolean "public"
    t.text "participation_conditions"
    t.text "operation_conditions"
    t.string "contact_email"
    t.text "data"
    t.date "installation_date"
    t.string "website_url"
    t.string "location_information"
    t.string "slug"
    t.string "formatted_name"
    t.boolean "metropole_funding"
    t.integer "gid"
    t.text "json_api_data"
    t.datetime "api_updated_at"
    t.index ["organisation_id"], name: "index_sites_on_organisation_id"
    t.index ["slug"], name: "index_sites_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "firstname"
    t.string "lastname"
    t.text "bio"
    t.boolean "super_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "organisations", "users"
  add_foreign_key "sites", "organisations"
end
