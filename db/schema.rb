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

ActiveRecord::Schema.define(version: 2020_10_10_050207) do

  create_table "event_comments", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_event_comments_on_participant_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "participant_id"
    t.datetime "date_and_time", null: false
    t.string "event_name", null: false
    t.text "content", null: false
    t.integer "number_of_reservations", default: 0, null: false
    t.string "image_id"
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_events_on_participant_id"
  end

  create_table "infos", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_infos_on_participant_id"
  end

  create_table "organizers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_organizers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_organizers_on_reset_password_token", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.text "nickname", null: false
    t.string "telephone_number", null: false
    t.boolean "is_deleted", default: false, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_participants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_participants_on_reset_password_token", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.integer "event_id", null: false
    t.integer "attendance_status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reservations_on_event_id"
    t.index ["participant_id"], name: "index_reservations_on_participant_id"
  end

end
