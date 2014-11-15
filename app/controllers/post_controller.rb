class PostController < ApplicationController
  before_filter :authenticate_user!
  layout "post"
  def new
    @sql = "select * from tasks t where t.status =1 and t.type_flag = 1
      and t.id not in (select tt.id from tasks tt inner join user_posts up on up.task_id = tt.id and up.user_id = " << current_user.id.to_s << " )
      and t.responsecap > (select count(id) from user_posts where task_id = t.id) order by t.id limit 1#"
    @task_temp = Task.find_by_sql(@sql)
    if (@task_temp != nil && @task_temp[0] != nil)
      @photos = TasksPhoto.find_all_by_task_id(@task_temp[0]['id'])
      @task_temp[0]['photos'] = @photos
    end
    @task = @task_temp[0].to_json;
  end
  
  def create
    #find the movement of the task to another level.
   @posts = UserPost.where('task_id = ?',params[:user_post][:task_id]) 
   @task = Task.find(params[:user_post][:task_id])
   @cnt = @posts.count +1
   if @cnt <  @task.responsecap
     @post =  UserPost.new(params[:user_post])
    respond_to do |format|
      if @post.save()
 #       format.html { 
 #          flash.now[:notice]="Save proccess coudn't be completed!" 
 #          render :new 
 #        }
        format.json { render json: '201', status: :created }
      end
    end
  elsif @cnt ==  @task.responsecap
    @task.status = 2 #move to voting phase
    @task.save()
    @post =  UserPost.new(params[:user_post])
    respond_to do |format|
      if @post.save()
 #       format.html { 
 #          flash.now[:notice]="Save proccess coudn't be completed!" 
 #          render :new 
 #        }
        format.json { render json: '200', status: :created }
      end
    end
  end
     
  end
  
  def edit
    @sql = "select * from tasks t
      where t.status =1 and t.type_flag = 2
      and t.id not in (select tt.id from tasks tt inner join userpost up on up.taskid = tt.id and up.createdby = " << current_user.id.to_s << " )
      and t.responsecap > (select count(id) from userpost where taskid = t.id) order by t.id limit 1"
    @task_temp = Tasks.find_by_sql(@sql)
    if (@task_temp != nil && @task_temp[0] != nil)
      @photos = Tasksphotos.find_all_by_taskid(@task_temp[0]['id'])
      @task_temp[0]['photos'] = @photos.to_json
    end
    @task = @task_temp.to_json
    render "edit"
  end
  
  def evaluate
    @sql = "select * from tasks t
      where t.status =1 and t.type_flag = 3
      and t.id not in (select tt.id from tasks tt inner join userpost up on up.taskid = tt.id and up.createdby = " << current_user.id.to_s << " )
      and t.responsecap > (select count(id) from userpost where taskid = t.id) order by t.id limit 1"
    @task_temp = Tasks.find_by_sql(@sql)
    if (@task_temp != nil && @task_temp[0] != nil) 
        @photos = Tasksphotos.find_all_by_taskid(@task_temp[0]['id'])
        @task_temp[0]['photos'] = @photos.to_json
    end
    
    @task = @task_temp.to_json
    
    render "evaluate"
  end
  
end
