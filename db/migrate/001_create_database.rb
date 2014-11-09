# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class CreateDatabase < ActiveRecord::Migration
  def self.up
    create_table "questionoptions", :force => true do |t|
      t.integer "questionid"
      t.string  "title",              :limit => 245
      t.integer "status"
      t.string  "questionoptionscol", :limit => 45
    end

    add_index "questionoptions", ["questionid"], :name => "options_question_fk1_idx"

    create_table "taskcompetition", :force => true do |t|
      t.integer "taskid"
      t.integer "currentassignee"
      t.integer "status"
      t.string  "taskcompetitioncol", :limit => 45
      t.integer "userpostid"
    end

    add_index "taskcompetition", ["taskid"], :name => "comp_task_fk1_idx"
    add_index "taskcompetition", ["userpostid"], :name => "comp_post_fk1_idx"

    create_table "taskquestions", :force => true do |t|
      t.integer  "taskid"
      t.string   "title",       :limit => 500
      t.integer  "type_flag"
      t.datetime "createddate"
    end

    add_index "taskquestions", ["taskid"], :name => "question_task_fk1_idx"

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
      t.datetime "createddate"
      t.datetime "updateddate"
      t.integer  "createdby"
      t.integer  "industrycategoryid"
      t.string   "client",             :limit => 245
      t.integer  "status"

    end

    create_table "tasksphotos", :force => true do |t|
      t.string   "imagename",   :limit => 245
      t.integer  "taskid"
      t.string   "status",      :limit => 45
      t.datetime "createddate"
    end

    add_index "tasksphotos", ["taskid"], :name => "taskphoto_tasks_fk_1_idx"

    create_table "userevaluate", :force => true do |t|
      t.integer  "taskid"
      t.text     "answers"
      t.string   "createdby",   :limit => 45
      t.datetime "createddate"
    end

    add_index "userevaluate", ["createdby"], :name => "evaluate_user_fk1_idx"
    add_index "userevaluate", ["taskid"], :name => "evaluate_task_fk1_idx"

    create_table "userpost", :force => true do |t|
      t.integer  "taskid"
      t.integer  "photoid"
      t.text     "description", :limit => 16777215
      t.integer  "createdby"
      t.datetime "createddate"
    end

    add_index "userpost", ["createdby"], :name => "post_user_fk1_idx"
    add_index "userpost", ["photoid"], :name => "post_photo_fk1_idx"
    add_index "userpost", ["taskid"], :name => "post_task_fk1_idx"

    create_table "uservote", :force => true do |t|
      t.integer  "taskid"
      t.integer  "createdby"
      t.datetime "createddate"
    end

    add_index "uservote", ["createdby"], :name => "vote_user_fk1_idx"
    
    
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
