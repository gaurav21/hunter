# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class CreateDatabase < ActiveRecord::Migration
  def self.up
            create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end

      add_index :users, :email,                unique: true
      add_index :users, :reset_password_token, unique: true
      # add_index :users, :confirmation_token,   unique: true
      # add_index :users, :unlock_token,         unique: true

    end
    
    create_table "tasks", :force => true do |t|
      t.string   "name",                                     :null => false
      t.integer  "type_flag",                                     :null => false
      t.integer  "source",                                   :null => false
      t.string   "instructions",       :limit => 5000,       :null => false
      t.text     "description",        :limit => 2147483647
      t.string   "url"
      t.integer  "responsecap"
      t.datetime "deadline"
      t.float    "reward"
      t.integer  "flagged"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "user_id"
      t.integer  "industry_category_id"
      t.string   "client",             :limit => 245
      t.integer  "status"

    end
    
  
   create_table "tasks_photos", :force => true do |t|
      t.string   "imagename",   :limit => 245
      t.integer  "task_id"
      t.string   "status",      :limit => 45
      t.datetime "created_at"
    end

    add_index "tasks_photos", ["task_id"], :name => "taskphoto_tasks_fk_1_idx"
    
    create_table "question_options", :force => true do |t|
      t.integer "question_id"
      t.string  "title",              :limit => 245
      t.integer "status"
      t.string  "question_options_col", :limit => 45
    end

    add_index "question_options", ["question_id"], :name => "options_question_fk1_idx"

    create_table "task_competitions", :force => true do |t|
      t.integer "task_id"
      t.integer "currentassignee"
      t.integer "status"
      t.string  "task_competition_col", :limit => 45
      t.integer "user_post_id"
      t.datetime "created_at"
    end

    add_index "task_competitions", ["task_id"], :name => "comp_task_fk1_idx"
    add_index "task_competitions", ["user_post_id"], :name => "comp_post_fk1_idx"

    create_table "task_questions", :force => true do |t|
      t.integer  "task_id"
      t.string   "title",       :limit => 500
      t.integer  "type_flag"
      t.datetime "created_at"
    end

    add_index "task_questions", ["task_id"], :name => "question_task_fk1_idx"

    create_table "user_evaluates", :force => true do |t|
      t.integer  "task_id"
      t.text     "answers"
      t.string   "user_id"
      t.datetime "created_at"
    end

    add_index "user_evaluates", ["user_id"], :name => "evaluate_user_fk1_idx"
    add_index "user_evaluates", ["task_id"], :name => "evaluate_task_fk1_idx"

    create_table "user_posts", :force => true do |t|
      t.integer  "task_id"
      t.integer  "tasks_photo_id"
      t.text     "description", :limit => 16777215
      t.integer  "user_id"
      t.datetime "created_at"
    end

    add_index "user_posts", ["user_id"], :name => "post_user_fk1_idx"
    add_index "user_posts", ["tasks_photo_id"], :name => "post_photo_fk1_idx"
    add_index "user_posts", ["task_id"], :name => "post_task_fk1_idx"

    create_table "user_votes", :force => true do |t|
      t.integer  "task_id"
      t.integer  "user_id"
      t.datetime "created_at"
    end

    add_index "user_votes", ["user_id"], :name => "vote_user_fk1_idx"
    

    def self.down
      # drop all the tables if you really need
      # to support migration back to version 0
      drop_table  :uservote
      drop_table  :tasksphotos
      drop_table  :tasks
      drop_table  :userevaluate
      drop_table  :userpost
      drop_table  :questionoptions
      drop_table  :taskcompetition
      drop_table  :taskcompetition
      drop_table  :users

      
    end
end
