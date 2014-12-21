class TasksController < ApplicationController
#before_filter :authenticate_user!
  layout "post"

  def index
    reward = params[:reward]
    qualification = params[:qualification]
    category = params[:category]
    tasks = Array.new
     sql = "select * from tasks t where t.status =1 
      and t.id not in (select tt.id from tasks tt inner join user_posts up on up.task_id = tt.id and up.user_id = " << current_user.id.to_s << " )
      and t.responsecap > (select count(id) from user_posts where task_id = t.id) order by t.id "
    if (reward != nil)
      sql = sql + " and t.reward > " + reward.max
    end
    
    if (qualification != nil)
      sql = sql + " and t.level in (" + qualification.join(',') + ")"
    end
    
    if (category != nil)
      sql = sql + " and t.category in (" + category.join(',') + ")"
    end
    
    task_temp = Task.find_by_sql(sql)
    if (task_temp != nil && task_temp[0] != nil)
      for   task1 in task_temp
        photos = TasksPhoto.find_all_by_task_id(task1['id'])
        task1['photos'] = photos
        tasks.push(task1)
      end
    end
    @task = tasks.to_json();
  end
  
  
    
  def create_query(id) 
        @sql = "select * from tasks t where t.status =1 and t.type_flag = " + id.to_s +
      " and t.id not in (select tt.id from tasks tt inner join user_posts up on up.task_id = tt.id and up.user_id = " << current_user.id.to_s << " )
      and t.responsecap > (select count(id) from user_posts where task_id = t.id) order by t.id limit 1"
    return @sql
  end
  
  def create
    reward = params[:reward]
    qualification = params[:qualification]
    category = params[:category]
    tasks = Array.new
    userid = params[:userid]
     sql = "select * from tasks t where t.status =1 "
     if (qualification != nil)
     # sql = sql + " and "
#      qualification.each do |i|
#        sql = sql + " t.level = " + i + " OR "
#      end
      sql = sql + " and ( t.level = " + qualification.join(' OR t.level = ') + ")"
    end
    
    if (reward != nil)
      sql = sql + " and t.reward > " + reward.max
    end
    
    if (category != nil)
      sql = sql + " and ( t.category = " + category.join(' OR t.category = ') + ")"
    end
    
     sql = sql + " and t.id not in (select tt.id from tasks tt inner join user_posts up on up.task_id = tt.id and up.user_id = " << userid << " )
      and t.responsecap > (select count(id) from user_posts where task_id = t.id) order by t.id "
    
    
    
    
    
    
    task_temp = Task.find_by_sql(sql)
    if (task_temp != nil && task_temp[0] != nil)
      for   task1 in task_temp
        photos = TasksPhoto.find_all_by_task_id(task1['id'])
        task1['photos'] = photos
        tasks.push(task1)
      end
    end
#    @task = tasks.to_json();
    respond_to do |format|
         format.json { render json: tasks, status: :created  }
      end
  end  
end
