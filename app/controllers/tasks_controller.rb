class TasksController < ApplicationController
  def index
    @tasks = Task.joins(:priority).includes(:priority).order(created_at: :desc).page(params[:page])
  end

  def new
    @task = Task.new
    @priorities = Priority.all
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を作成しました"
    else
      render :action => "new"
    end

  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
    @priorities = Priority.all
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を更新しました。"
    else
      render :action => "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスク#{@task.name}を削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:name,:description,:priority_id,:deadline)
  end

end
