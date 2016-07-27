# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160727004237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "faves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "pet_id"
  end

  add_index "faves", ["pet_id"], name: "index_faves_on_pet_id", using: :btree
  add_index "faves", ["user_id", "pet_id"], name: "index_faves_on_user_id_and_pet_id", unique: true, using: :btree
  add_index "faves", ["user_id"], name: "index_faves_on_user_id", using: :btree

  create_table "pets", force: :cascade do |t|
    t.integer  "animal_type",  null: false
    t.string   "breed"
    t.integer  "age"
    t.integer  "sex"
    t.string   "size"
    t.string   "name",         null: false
    t.string   "location"
    t.text     "description"
    t.string   "petfinder_id"
    t.integer  "shelter_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "pets", ["shelter_id"], name: "index_pets_on_shelter_id", using: :btree

  create_table "shelters", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "location",     null: false
    t.string   "petfinder_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
