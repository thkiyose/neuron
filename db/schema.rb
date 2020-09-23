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

ActiveRecord::Schema.define(version: 2020_09_23_053053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contribution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contribution_id"], name: "index_favorites_on_contribution_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "contribution_id"
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contribution_id"], name: "index_posts_on_contribution_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "screen_name", limit: 20, default: "ユーザー", null: false
    t.text "introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "user_relations", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_user_relations_on_followed_id"
    t.index ["followed_id"], name: "index_user_relations_on_followed_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_user_relations_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "contributions", "users"
  add_foreign_key "favorites", "contributions"
  add_foreign_key "favorites", "users"
  add_foreign_key "posts", "contributions"
  add_foreign_key "profiles", "users"
end
