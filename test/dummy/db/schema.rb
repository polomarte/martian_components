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

ActiveRecord::Schema.define(version: 20160630170216) do

  create_table "component_translations", force: :cascade do |t|
    t.integer  "component_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "title"
    t.string   "h1"
    t.string   "h2"
    t.text     "text"
  end

  add_index "component_translations", ["component_id"], name: "index_component_translations_on_component_id"
  add_index "component_translations", ["locale"], name: "index_component_translations_on_locale"

  create_table "components", force: :cascade do |t|
    t.string   "type"
    t.string   "key"
    t.string   "title"
    t.string   "h1"
    t.string   "h2"
    t.text     "text"
    t.text     "data"
    t.boolean  "affix_nav_navegable", default: false
    t.string   "file"
    t.integer  "parent_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_translations", force: :cascade do |t|
    t.integer  "image_id",    null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
  end

  add_index "image_translations", ["image_id"], name: "index_image_translations_on_image_id"
  add_index "image_translations", ["locale"], name: "index_image_translations_on_locale"

  create_table "images", force: :cascade do |t|
    t.string   "type"
    t.string   "kind"
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.boolean  "active",         default: false
    t.string   "file"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
