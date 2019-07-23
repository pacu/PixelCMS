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

ActiveRecord::Schema.define(:version => 20140428234947) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "admin_user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "contents", :force => true do |t|
    t.integer  "section_id"
    t.string   "title"
    t.integer  "start_page"
    t.integer  "end_page"
    t.string   "preview_text"
    t.string   "thumbnail"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "issue_states", :force => true do |t|
    t.string   "name"
    t.integer  "next_state_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "issues", :force => true do |t|
    t.integer  "publication_id"
    t.string   "name"
    t.integer  "issue_number"
    t.integer  "pdf_length"
    t.date     "release_date"
    t.string   "pdf_zip"
    t.string   "product_id"
    t.string   "cover"
    t.string   "newsstand_cover"
    t.boolean  "is_free"
    t.string   "app_store_description"
    t.integer  "issue_state_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "proceedings", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "publisher_id"
    t.float    "total_usd"
    t.date     "deposit_date"
    t.float    "exchange_rate"
    t.float    "share_percent"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.date     "payment_date"
    t.string   "name",          :limit => nil
  end

  create_table "publication_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "publications", :force => true do |t|
    t.integer  "publisher_id"
    t.integer  "publication_type_id"
    t.string   "name"
    t.string   "product_code"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "publications", ["product_code"], :name => "index_publications_on_product_code"

  create_table "publishers", :force => true do |t|
    t.string   "name"
    t.float    "share_percent"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "publisher_id"
    t.integer  "publication_id"
    t.string   "object_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "roles", ["object_type"], :name => "index_roles_on_object_type"

  create_table "sales", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "upc"
    t.string   "isrc_isbn"
    t.string   "product_identifier"
    t.integer  "quantity"
    t.float    "partner_share"
    t.float    "extended_partner_share"
    t.string   "partner_share_currency"
    t.string   "sales_return"
    t.string   "apple_identifier"
    t.string   "seller_type"
    t.string   "label_studio"
    t.string   "grid"
    t.string   "product_type"
    t.string   "isan"
    t.string   "country"
    t.float    "customer_price"
    t.string   "customer_currency"
    t.float    "usd_exchange_rate"
    t.string   "promo_code"
    t.string   "preorder_flag"
    t.float    "share_usd"
    t.integer  "publisher_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "sales", ["product_identifier"], :name => "index_sales_on_product_identifier"

  create_table "sections", :force => true do |t|
    t.integer  "issue_id"
    t.string   "title"
    t.integer  "page_number"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
