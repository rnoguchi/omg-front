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

ActiveRecord::Schema.define(version: 20170930054042) do

  create_table "gs_store_groups", force: :cascade do |t|
    t.string   "store_group_id", null: false
    t.string   "store_name",     null: false
    t.datetime "upd_date"
    t.string   "upd_apl"
    t.datetime "reg_date"
    t.string   "reg_apl"
    t.integer  "version"
  end

  add_index "gs_store_groups", ["store_group_id", "store_name"], name: "index_gs_store_groups_on_store_group_id_and_store_name", unique: true

  create_table "gs_store_infos", force: :cascade do |t|
    t.string   "store_id"
    t.string   "gs_cd"
    t.string   "store_name"
    t.string   "store_img_url"
    t.string   "business_hours"
    t.string   "holiday"
    t.string   "pc_site_url"
    t.string   "mobile_site_url"
    t.float    "evaluation_score"
    t.string   "genre"
    t.string   "average_dinner_price"
    t.string   "average_lunch_price"
    t.boolean  "visit_already_flg"
    t.datetime "upd_date"
    t.string   "upd_apl"
    t.datetime "reg_date"
    t.string   "reg_apl"
    t.integer  "version"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "store_group_id"
  end

  add_index "gs_store_infos", ["store_id", "gs_cd"], name: "index_gs_store_infos_on_store_id_and_gs_cd", unique: true

end
