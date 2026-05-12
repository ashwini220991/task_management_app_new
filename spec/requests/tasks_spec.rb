require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) do
    User.create!(
      email: 'test@example.com',
      password: 'password123'
    )
  end

  before do
    sign_in user
  end

  it "loads tasks index" do
    get tasks_path
    expect(response).to have_http_status(:success)
  end

  it "loads new task page" do
    get new_task_path
    expect(response).to have_http_status(:success)
  end
end
