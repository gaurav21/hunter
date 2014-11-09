class PostController < ApplicationController
  #before_action  :authenticate_user!
 

  def index
    @sql = "select * from tasks t
      where t.status =1
    and t.id not in (select tt.id from tasks tt inner join userpost up on up.taskid = tt.id and up.createdby = #" << current_user.id.to_s << " )
    and t.responsecap > (select count(id) from userpost where taskid = t.id)"
    @task = Tasks.all.to_json;
  end
end
