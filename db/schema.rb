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

ActiveRecord::Schema.define(version: 20160605184821) do

  create_table "project_updates", force: :cascade do |t|
    t.integer  "project_id",  limit: 4
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "user_id",     limit: 4
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "stage_id",        limit: 4,     default: 1, null: false
    t.string   "subject",         limit: 255
    t.text     "description",     limit: 65535
    t.string   "user_url",        limit: 255
    t.string   "development_url", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "projects_skills", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "skill_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "projects_users", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "projects_users", ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id", unique: true, using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "skills", ["name"], name: "index_skills_on_name", unique: true, using: :btree

  create_table "skills_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "skill_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "stages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "email",            limit: 255
    t.text     "description",      limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.string   "image",            limit: 255
  end

end
