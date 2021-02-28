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

ActiveRecord::Schema.define(version: 2021_02_13_182401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_events", force: :cascade do |t|
    t.decimal "businessEventID"
    t.decimal "numOfPoints"
    t.date "submissionDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "member_points", force: :cascade do |t|
    t.decimal "businessTableID"
    t.string "events"
    t.decimal "points"
    t.string "eventType"
    t.decimal "userID"
    t.decimal "speakingEventID"
    t.decimal "businessEventID"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "org_events", force: :cascade do |t|
    t.daterange "upcomingActivities"
    t.date "date"
    t.string "name"
    t.boolean "required"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "speaking_events", force: :cascade do |t|
    t.decimal "speakingEventID"
    t.decimal "numOfPoints"
    t.date "submissionDate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.decimal "userID"
    t.boolean "isOfficer"
    t.date "joinDate"
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end