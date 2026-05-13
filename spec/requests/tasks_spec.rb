require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) do
    User.create!(
      email: "user@example.com",
      password: "password123"
    )
  end

  let(:task) do
    Task.create!(
      title: "Sample Task",
      description: "This is a sample valid task description",
      completed: false,
      user: user
    )
  end

  before do
    sign_in user
  end

  describe "GET /tasks" do
    it "returns success" do
      get tasks_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /tasks/new" do
    it "renders new task page" do
      get new_task_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /tasks" do
    it "creates a task" do
      expect {
        post tasks_path, params: {
          task: {
            title: "New Task",
            description: "This is a newly created valid task"
          }
        }
      }.to change(Task, :count).by(1)
    end
  end

  describe "PATCH /tasks/:id" do
    it "updates task" do
      patch task_path(task), params: {
        task: {
          title: "Updated Task",
          description: "Updated valid description for testing"
        }
      }

      expect(task.reload.title).to eq("Updated Task")
    end
  end

  describe "PATCH /tasks/:id/mark_complete" do
    it "marks task complete" do
      patch mark_complete_task_path(task)

      expect(task.reload.completed).to eq(true)
    end
  end

  describe "PATCH /tasks/:id/mark_incomplete" do
    it "marks task incomplete" do
      task.update(completed: true)

      patch mark_incomplete_task_path(task)

      expect(task.reload.completed).to eq(false)
    end
  end

  describe "DELETE /tasks/:id" do
    it "deletes task" do
      task

      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)
    end
  end
end
