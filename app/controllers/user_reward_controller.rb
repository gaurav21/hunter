class UserRewardController < ApplicationController
  
  def create
    result = Array.new
    rewards = UserReward.where('user_id = ?', 2)
    for reward in rewards
      if reward.reward_type == 1
        reward['title']= 'You won a microcontest'
        result.push(reward)
      end
      if reward.reward_type == 2
        reward['title']= 'You were a runner up in microcontest '
        result.push(reward)
      end
    end
    respond_to do |format|
         format.json { render json: result.to_json, status: :created  }
      end
  end
end