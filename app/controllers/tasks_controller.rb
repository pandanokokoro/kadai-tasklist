class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    if logged_in?
      puts current_user[:id]
      #@tasks = Task.find_by(user_id: 4)
      @tasks = Task.all
      @tasks = current_user.tasks
      # @pagy, @tasks = pagy(current_user.tasks.order(id: :desc))
    end
  end
  
  def show
    @user = current_user[:id]
    @exe_user = Task.find(params[:id]).user_id

    if @user == @exe_user
      @task = Task.find(params[:id])
    else
      redirect_to root_url
    end
  end
  
  def new
    @task = Task.new
  end
  
  def create
    # puts params
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "Taskが正常に登録されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskが登録されませんでした"
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "Taskは正常に更新されました"
      redirect_to @task
    else
      flash[:danger] = "Taskは更新されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "Taskは正常に削除されました"
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def ensure_correct_user
    @task = Task.find(params[:id])
    unless @task.user_id == current_user[:id]
    end
  end
end










