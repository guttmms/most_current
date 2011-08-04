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

ActiveRecord::Schema.define(:version => 20110804162421) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret"
  end

  create_table "contact_keys", :force => true do |t|
    t.integer  "key_id"
    t.integer  "linked_contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forward_keys", :force => true do |t|
    t.integer  "forward_table_id"
    t.integer  "key_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forward_tables", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "friend_min_hops", :force => true do |t|
    t.integer  "received_key_id"
    t.integer  "friend_id"
    t.integer  "h_min"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keys", :force => true do |t|
    t.integer  "user_id"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "linked_contacts", :force => true do |t|
    t.integer  "user_id"
    t.text     "headline"
    t.string   "uid"
    t.string   "last_name"
    t.string   "picture_url"
    t.string   "location"
    t.string   "industry"
    t.string   "first_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "message_users", :force => true do |t|
    t.integer  "prop_message_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "industry"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prop_messages", :force => true do |t|
    t.integer  "forward_key_id"
    t.string   "pid"
    t.integer  "hops_remaining"
    t.integer  "hops_covered"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "origin_id"
  end

  create_table "qid_table_qids", :force => true do |t|
    t.integer  "qid_table_id"
    t.integer  "qid_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qid_tables", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qids", :force => true do |t|
    t.string   "qid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "received_keys", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "received_table_id"
    t.integer  "key_id"
    t.integer  "max_hops"
  end

  create_table "received_tables", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
