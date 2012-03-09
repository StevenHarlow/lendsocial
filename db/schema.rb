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

ActiveRecord::Schema.define(:version => 20120309191645) do

  create_table "business_connections", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.integer  "initiator_id"
    t.datetime "response_at"
    t.datetime "viewed_at"
    t.text     "message"
  end

  add_index "business_connections", ["followed_id"], :name => "index_business_connections_on_followed_id"
  add_index "business_connections", ["follower_id"], :name => "index_business_connections_on_follower_id"

  create_table "business_followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "business_followings", ["followed_id"], :name => "index_business_followings_on_followed_id"
  add_index "business_followings", ["follower_id"], :name => "index_business_followings_on_follower_id"

  create_table "businesses", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.datetime "business_started"
    t.text     "description"
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
    t.text     "description"
    t.text     "benefits"
    t.text     "thank_you_message"
    t.datetime "published_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["business_id"], :name => "index_loans_on_business_id"
  add_index "loans", ["loan_purpose_id"], :name => "index_loans_on_loan_purpose_id"
  add_index "loans", ["user_id"], :name => "index_loans_on_user_id"

  create_table "messages", :force => true do |t|
    t.integer  "author_id"
    t.integer  "by_business_id"
    t.integer  "posted_to_id"
    t.string   "posted_to_type"
    t.integer  "related_message_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["author_id"], :name => "index_messages_on_author_id"
  add_index "messages", ["by_business_id"], :name => "index_messages_on_by_business_id"
  add_index "messages", ["posted_to_id"], :name => "index_messages_on_posted_to_id"
  add_index "messages", ["related_message_id"], :name => "index_messages_on_related_message_id"

  create_table "user_businesses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "business_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_businesses", ["business_id"], :name => "index_user_businesses_on_business_id"
  add_index "user_businesses", ["user_id"], :name => "index_user_businesses_on_user_id"

  create_table "user_followings", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_followings", ["followed_id"], :name => "index_user_followings_on_followed_id"
  add_index "user_followings", ["follower_id"], :name => "index_user_followings_on_follower_id"

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.text     "about"
    t.string   "user_picture"
  end

end
