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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120119023132) do

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "follower_id"
    t.boolean  "blocked"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loan_purposes", :force => true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", :force => true do |t|
    t.integer  "business_id"
    t.integer  "user_id"
    t.datetime "request_date"
    t.decimal  "amount_requested"
    t.datetime "funding_deadline"
    t.integer  "loan_purpose_id"
    t.datetime "funded_date"
    t.decimal  "total_committed"
    t.string   "description"
    t.string   "benefits"
    t.string   "thank_you_message"
    t.datetime "published_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["business_id"], :name => "index_loans_on_business_id"
  add_index "loans", ["loan_purpose_id"], :name => "index_loans_on_loan_purpose_id"
  add_index "loans", ["user_id"], :name => "index_loans_on_user_id"

  create_table "profile_activities", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "actor_id"
    t.string   "name"
    t.string   "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "public"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_businesses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_businesses", ["business_id"], :name => "index_user_businesses_on_business_id"
  add_index "user_businesses", ["user_id"], :name => "index_user_businesses_on_user_id"

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
