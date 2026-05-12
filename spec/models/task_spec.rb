require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create!(
      email: 'test@example.com',
      password: 'password123'
    )
  end

  it 'is valid with title and user' do
    task = Task.new(
      title: 'Test Task',
      user: user
    )

    expect(task).to be_valid
  end

  it 'is invalid without title' do
    task = Task.new(
      title: nil,
      user: user
    )

    expect(task).not_to be_valid
  end
end
