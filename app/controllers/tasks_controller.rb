class TasksController < ApplicationController
  before_action :require_user_logged_in
  #before_action :set_task_user, only: [:show, :edit, :update, :destroy]
  #before_action :check_user, only: [:show, :edit, :update, :destroy]
  #before_action :user_control, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  def index
    if logged_in?
      # @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      @tasks = Task.where(user: current_user).order(id: :desc).page(params[:page])
    end
  end

  def show
  end

  def new
    # @task = Task.new
    # @task = current_user.tasks.build
    @task = Task.new
    @task.user = current_user
  end

  def create
    # params[:task][:content]
    # params[:task][:status]
    # @task = current_user.tasks.build(task_params)
    @task = Task.new(task_params)
    @task.user = current_user
    # @task.user_id = current_user.id

    if @task.save
      flash[:success] = '新規タスクが作成されました'
      redirect_to root_path
      
    else
      flash[:danger] = 'タスクが作成できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが更新されました'
      redirect_to @task
    else
      flash[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは消去されました'
    redirect_to tasks_url
  end
  
  private
  
  #def set_task_user
    #@task = current_user.tasks.find_by(id: params[:id])
  #end
  
  #def check_user
    #redirect_to root_url if @task.blank?
  #end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  #def user_control
    #@task.user = current_user
  #end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end