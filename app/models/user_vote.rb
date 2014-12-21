class UserVote < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :task_id, :user_post_won_id, :user_post_lost_id, :user_id
  belongs_to :task
end
