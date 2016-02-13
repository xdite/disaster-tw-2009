# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090817083429) do

  create_table "counties", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "posts_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "counties", ["posts_count"], :name => "index_counties_on_posts_count"

  create_table "down_votes", :force => true do |t|
    t.integer  "post_id"
    t.integer  "created_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "down_votes", ["created_ip"], :name => "index_down_votes_on_created_ip"
  add_index "down_votes", ["post_id"], :name => "index_down_votes_on_post_id"

  create_table "help_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "miscs", :force => true do |t|
    t.text     "content"
    t.string   "misc_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "post_attachments", :force => true do |t|
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_attachments", ["post_id"], :name => "index_post_attachments_on_post_id"
  add_index "post_attachments", ["user_id"], :name => "index_post_attachments_on_user_id"

  create_table "post_comments", :force => true do |t|
    t.text     "content"
    t.string   "username"
    t.integer  "post_id"
    t.integer  "user_id"
    t.string   "created_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "content_html"
  end

  add_index "post_comments", ["created_ip"], :name => "index_post_comments_on_created_ip"

  create_table "posts", :force => true do |t|
    t.integer  "county_id"
    t.integer  "user_id"
    t.string   "subject"
    t.text     "content"
    t.integer  "down_votes_count",    :default => 0
    t.integer  "post_comments_count", :default => 0
    t.string   "created_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "help_type_id",        :default => 1
    t.text     "content_html"
    t.integer  "spams_count",         :default => 0
    t.integer  "source_type_id"
  end

  add_index "posts", ["county_id"], :name => "index_posts_on_county_id"
  add_index "posts", ["created_ip"], :name => "index_posts_on_created_ip"
  add_index "posts", ["post_comments_count"], :name => "index_posts_on_post_comments_count"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "source_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spams", :force => true do |t|
    t.integer  "post_id"
    t.integer  "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_ip"
  end

  add_index "spams", ["created_ip", "post_id"], :name => "index_spams_on_created_ip_and_post_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "urls", :force => true do |t|
    t.string   "link"
    t.string   "title"
    t.string   "ppt_url"
    t.string   "state"
    t.string   "processing_error_message"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "urls", ["post_id"], :name => "index_urls_on_post_id"

  create_table "user_buddy_icons", :force => true do |t|
    t.string   "type"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_buddy_icons", ["user_id"], :name => "index_user_buddy_icons_on_user_id"

  create_table "user_openids", :force => true do |t|
    t.string   "openid_url", :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_openids", ["openid_url"], :name => "index_user_openids_on_openid_url"
  add_index "user_openids", ["user_id"], :name => "index_user_openids_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "site_url"
    t.string   "yahoo_userhash"
    t.string   "gender"
    t.text     "description"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "posts_count",                              :default => 0
    t.integer  "post_comments_count",                      :default => 0
    t.string   "identity_url"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["post_comments_count"], :name => "index_users_on_post_comments_count"
  add_index "users", ["posts_count"], :name => "index_users_on_posts_count"

end
