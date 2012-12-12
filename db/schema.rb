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

ActiveRecord::Schema.define(:version => 20121212083021) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
  end

  create_table "blogs", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.integer  "written_at"
    t.integer  "authorization_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "name"
  end

  create_table "dashboards", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "web_property_id"
    t.integer  "user_id"
    t.integer  "blog_id"
  end

  create_table "post_data_sets", :force => true do |t|
    t.string   "uid"
    t.integer  "notes"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "post_id"
  end

  create_table "posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "url"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "uid"
    t.datetime "posted_at"
    t.string   "type_of"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "email"
  end

end
