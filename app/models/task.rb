class Task < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tasks_photos
  has_many :user_post
end
