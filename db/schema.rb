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

ActiveRecord::Schema.define(:version => 20120621191959) do

  create_table "appointments", :force => true do |t|
    t.text     "topic",                           :null => false
    t.date     "date",                            :null => false
    t.string   "time"
    t.string   "via",        :default => "email", :null => false
    t.integer  "contact_id",                      :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "name",                         :null => false
    t.string   "lastname",                     :null => false
    t.string   "email",                        :null => false
    t.string   "skypeid"
    t.string   "phone"
    t.boolean  "wish_info",  :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "contacts", ["email"], :name => "index_contacts_on_email", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
