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

ActiveRecord::Schema.define(:version => 1) do

  create_table "question_options", :force => true do |t|
    t.integer "question_id"
    t.string  "title",                :limit => 245
    t.integer "status"
    t.string  "question_options_col", :limit => 45
  end

  add_index "question_options", ["question_id"], :name => "options_question_fk1_idx"

  create_table "task_competitions", :force => true do |t|
    t.integer  "task_id"
    t.integer  "currentassignee"
    t.integer  "status"
    t.string   "task_competition_col", :limit => 45
    t.integer  "user_post_id"
    t.datetime "created_at"
  end

  add_index "task_competitions", ["task_id"], :name => "comp_task_fk1_idx"
  add_index "task_competitions", ["user_post_id"], :name => "comp_post_fk1_idx"

  create_table "task_questions", :force => true do |t|
    t.integer  "task_id"
    t.string   "title",      :limit => 500
    t.integer  "type_flag"
    t.datetime "created_at"
  end

  add_index "task_questions", ["task_id"], :name => "question_task_fk1_idx"

  create_table "tasks", :force => true do |t|
    t.string   "name",                                       :null => false
    t.integer  "type_flag",                                  :null => false
    t.integer  "source",                                     :null => false
    t.string   "instructions",         :limit => 5000,       :null => false
    t.text     "description",          :limit => 2147483647
    t.string   "url"
    t.integer  "responsecap"
    t.datetime "deadline"
    t.float    "reward"
    t.integer  "flagged"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "industry_category_id"
    t.string   "client",               :limit => 245
    t.integer  "status"
  end

  create_table "tasks_photos", :force => true do |t|
    t.string   "imagename",  :limit => 245
    t.integer  "task_id"
    t.string   "status",     :limit => 45
    t.datetime "created_at"
  end

  add_index "tasks_photos", ["task_id"], :name => "taskphoto_tasks_fk_1_idx"

  create_table "user_evaluates", :force => true do |t|
    t.integer  "task_id"
    t.text     "answers"
    t.string   "user_id"
    t.datetime "created_at"
  end

  add_index "user_evaluates", ["task_id"], :name => "evaluate_task_fk1_idx"
  add_index "user_evaluates", ["user_id"], :name => "evaluate_user_fk1_idx"

  create_table "user_posts", :force => true do |t|
    t.integer  "task_id"
    t.integer  "tasks_photo_id"
    t.text     "description",    :limit => 16777215
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "user_posts", ["task_id"], :name => "post_task_fk1_idx"
  add_index "user_posts", ["tasks_photo_id"], :name => "post_photo_fk1_idx"
  add_index "user_posts", ["user_id"], :name => "post_user_fk1_idx"

  create_table "user_votes", :force => true do |t|
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "user_votes", ["user_id"], :name => "vote_user_fk1_idx"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
