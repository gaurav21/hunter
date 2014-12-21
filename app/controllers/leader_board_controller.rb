class LeaderBoardController < ApplicationController
#  before_filter :authenticate_user!
  layout "post"
  def index
    return_leader = Array.new
    sql = "select name,user_tier,IFNULL(total_reward, 0) as total_reward,IFNULL((total_reward/200),0) as dollor_val from users
    order by total_reward desc limit 0,10"
    
    leaders = User.find_by_sql(sql)
    @ldrs  = leaders.to_json() 
  end
end  