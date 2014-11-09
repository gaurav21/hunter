class TasksController < ApplicationController
  def tasks
    @task = Tasks.new;
    @task = Tasks.find(1);
  end
end
