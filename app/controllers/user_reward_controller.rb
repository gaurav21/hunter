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
  
  def purchaseperks
    perk = Perk.where('id = ?', params[:id]).first()
    flag = 0
    if perk != nil
      userperk = UserPerk.new
      userperk.user_id = current_user.id
      userperk.perk_id = params[:id]
      userperk.status = 1
      if userperk.save()
        wonuserreward1 = UserReward.new()
        #wonuserreward1.task_id = userPost.task_id
        #wonuserreward1.task_reward_amt = - perk.
        wonuserreward1.total_amt = -perk.cost_formula.to_i
        wonuserreward1.user_id = current_user.id
        wonuserreward1.reward_type = 5 #winning the contest
        if wonuserreward1.save()
          #reduce the total points
          user = User.where('id= ?', current_user.id).first()
          user.total_reward = user.total_reward - perk.cost_formula.to_i
          flag = user.save()
        end
      end
    end

    respond_to do |format|
         format.json { render json: flag, status: :created  }
      end
  end
end