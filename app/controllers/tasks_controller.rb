# Handles all CRUD operations for user tasks
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :mark_complete]

  # Show all tasks for logged-in user
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  # Show task 
  def show; end

  # Render new task creation form
  def new
    @task = current_user.tasks.new
  end
  
  # Create new task
  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Task created successfully.'
    else
      render :new
    end
  end

  # Render edit form
  def edit; end

  # Update existing task
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task updated successfully.'
    else
      render :edit
    end
  end

  # Delete task
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task deleted successfully.'
  end

  # Mark task as completed
  def mark_complete
    @task.update(completed: true)
    redirect_to tasks_path, notice: 'Task marked complete.'
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
