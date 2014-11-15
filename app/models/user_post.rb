class UserPost < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :task_id, :tasks_photo_id, :description, :user_id
  belongs_to :task
end
