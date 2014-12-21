class UserReward < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :task_id, :task_reward_amt, :perk_id, :total_amt, :user_id, :perk_reward_amt
  belongs_to :task
end
