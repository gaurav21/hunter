class VoteController < ApplicationController
  layout "post"
  def index
#    reward = params[:reward]
#    qualification = params[:qualification]
#    category = params[:category]
#    userid = params[:userid]
    if current_user != nil && current_user.id != nil
      userid = current_user.id.to_s
          sql = "select up.id,up.task_id, up.description,t.image,t.name from user_posts up
        inner join tasks t on t.id = up.task_id "
#    if (reward != nil)
#      sql = sql + " and t.reward > " + reward.max
#    end
#    
#    if (qualification != nil)
#      sql = sql + " and t.level in (" + qualification.join(',') + ")"
#    end
#    
#    if (category != nil)
#      sql = sql + " and t.category in (" + category.join(',') + ")"
#    end
     sql = sql +  " where up.task_id = (select tt.id from tasks tt where tt.status = 2 order by RAND() LIMIT 0,1)
      and up.user_id != " <<  userid << " 
      and (up.status is null or up.status = 1)
      and (select count(uv.id) from user_votes uv where user_post_won_id = up.id and user_id = " <<  userid << ") = 0
      order by RAND() LIMIT 0,2"
    
    @posts = UserPost.find_by_sql(sql).to_json()
    end

      
  end
  
  def votefortask
    userPost = UserPost.where('id = ? and status is null',params[:wonid]).first()
    uservote = UserVote.new()
    uservote.task_id = userPost.task_id
    uservote.user_post_won_id = params[:wonid]
    uservote.user_post_lost_id = params[:lostid]
    uservote.user_id = params[:userid]
    if uservote.save()
      userPost.total_votes = userPost.total_votes + 1
      if userPost.save()
        if userPost.total_votes == Variable.where('id = ? ', 1).first().value
          task = Task.where('id = ?', userPost.task_id).first()
          task.status = 3
          if task.save()
            userPost.status = 1 #won the contest
            if userPost.save()
              #check achievement
                achievement = UserReward.where('user_id = ? and reward_type = 1', userPost.user_id).count
                if achievement == 0
                  wonuserreward1 = UserReward.new()
                  wonuserreward1.task_id = userPost.task_id
                  wonuserreward1.task_reward_amt = 100
                  wonuserreward1.total_amt = 100
                  wonuserreward1.user_id = userPost.user_id
                  wonuserreward1.reward_type = 4 #winning the contest
                  wonuserreward1.save()
                end
              wonuserreward = UserReward.new()
              wonuserreward.task_id = userPost.task_id
              wonuserreward.task_reward_amt = task.reward
              wonuserreward.total_amt = task.reward
              wonuserreward.user_id = userPost.user_id
              wonuserreward.reward_type = 1 #winning the contest
              if wonuserreward.save()
                sql = "select * from user_posts where task_id = " << userPost.task_id.to_s  << " order by total_votes desc limit 1,1"
                runneruppost =  UserPost.find_by_sql(sql).first()
                if runneruppost != nil
                    lostuserreward = UserReward.new()
                    lostuserreward.task_id = runneruppost.task_id
                    lostuserreward.task_reward_amt = task.reward / 2
                    lostuserreward.total_amt = task.reward / 2
                    lostuserreward.user_id = runneruppost.user_id
                    lostuserreward.reward_type = 2 #this is for coming second
                    lostuserreward.save()
                end

              end
            end
          end
        end
      end
      respond_to do |format|
          format.json { render json: 1, status: :created  }
        end
    end
  end
  
  def votefortask1
    userPost = UserPost.where('id = ? and (status is null or status = 1)',params[:wonid]).first()
    if (userPost.status.nil? || userPost.status == 1) 
      userPost.status = 1
      userPost.voted_by = params[:userid]
      userPost.voted_date = Time.now
      if userPost.save()
        lostPost = UserPost.where('id = ? and (status is null or status = 1)',params[:lostid]).first()
        lostPost.status = 2
        lostPost.voted_by = params[:userid]
        lostPost.voted_date = Time.now
        if lostPost.save()
          count = UserPost.where('task_id = ? and (status = 1 or status is null)', userPost.task_id).count
          #Now the task needs to be figured whether its moving to done stage
          respond_to do |format|
                        format.json { render json: count, status: :created  }
                      end
          if count == 1
            task = Task.where('id = ?', userPost.task_id).first()
            task.status = 3
            if task.save()
              #award both users 
              wonuserreward = UserReward.new()
              wonuserreward.task_id = userPost.task_id
              wonuserreward.task_reward_amt = task.reward
              wonuserreward.total_amt = task.reward
              wonuserreward.user_id = userPost.user_id
              wonuserreward.reward_type = 1 #winning the contest
              if wonuserreward.save
                #add to  user reward
                user = User.where('id= ?', userPost.user_id).first()
                user.total_reward = user.total_reward + wonuserreward.total_amt
                user.save()
                #check achievement
                achievement = UserReward.where('user_id = ? and reward_type = 1', userPost.user_id).count
                if achievement == 0
                  wonuserreward = UserReward.new()
                  wonuserreward.task_id = userPost.task_id
                  wonuserreward.task_reward_amt = 100
                  wonuserreward.total_amt = 100
                  wonuserreward.user_id = userPost.user_id
                  wonuserreward.reward_type = 4 #winning the contest
                end
                
                lostuserreward = UserReward.new()
                lostuserreward.task_id = lostPost.task_id
                lostuserreward.task_reward_amt = task.reward / 2
                lostuserreward.total_amt = task.reward / 2
                lostuserreward.user_id = lostPost.user_id
                lostuserreward.reward_type = 2 #this is for coming second
                if lostuserreward.save()
                  #add to  user reward
                  user = User.where('id= ?', lostPost.user_id).first()
                  user.total_reward = user.total_reward + lostuserreward.total_amt
                  if user.save()
                    voteuserreward = UserReward.new()
                    voteuserreward.task_id = lostPost.task_id
                    voteuserreward.task_reward_amt = task.vote_reward
                    voteuserreward.total_amt = task.vote_reward
                    voteuserreward.user_id = current_user.id
                    voteuserreward.reward_type = 3 #for voting the winning 
                    if voteuserreward.save()
                      respond_to do |format|
                        format.json { render json: 1, status: :created  }
                      end
                    end  
                  end  
                end
              end
            end
          end
        end
          
#          respond_to do |format|
#            format.json { render json: 2, status: :created  }
#          end

#count = UserPost.where('task_id = ? and status = 1', userPost.task_id).count

#if count == 1
#  task = Task.where('id = ?', userPost.task_id)
#  task.status = 3
#  task.save()
#end
#if request.xhr?
#        render :json => {
#                            :status => 1
#                        }
#     end
        end
      end 
    end
 
  
  
  def create
        reward = params[:reward]
    qualification = params[:qualification]
    category = params[:category]
    userid = params[:userid]
    if current_user != nil && current_user.id != nil
      userid = current_user.id.to_s
    end
    sql = "select up.id,up.task_id, up.description,t.image,t.name from user_posts up
        inner join tasks t on t.id = up.task_id "
    if (reward != nil)
      sql = sql + " and t.reward > " + reward.max
    end
    
    if (qualification != nil)
      sql = sql + " and t.level in (" + qualification.join(',') + ")"
    end
    
    if (category != nil)
      sql = sql + " and t.category in (" + category.join(',') + ")"
    end
     sql = sql +  " where up.task_id = (select tt.id from tasks tt where tt.status = 2 order by RAND() LIMIT 0,1)
      and up.user_id != " <<  userid << " 
and up.voted_by is null or up.voted_by !=" <<  userid << "
      and (up.status is null or up.status = 1)
      order by RAND() LIMIT 0,2"
    
    posts = UserPost.find_by_sql(sql)
    respond_to do |format|
                        format.json { render json: posts.to_json(), status: :created  }
          end
  end  
end
