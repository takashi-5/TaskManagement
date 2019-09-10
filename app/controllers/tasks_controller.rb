class TasksController < ApplicationController
  def index
    @tasks = Task.joins(:priority, :status_table).includes(:priority, :status_table).order(created_at: :desc)
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
      @priorities = Priority.all
      @statuses = Status.all
      render :action => "new"
    end

  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
    @priorities = Priority.all
    @statuses = Status.all
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスク「#{@task.name}」を更新しました。"
    else
      @priorities = Priority.all
      @statuses = Status.all
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
    params.require(:task).permit(:name,:description,:priority_id,:deadline, :status)
  end

end
