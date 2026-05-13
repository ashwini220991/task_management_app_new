require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) do
    User.create!(
      email: "testuser@example.com",
      password: "password123"
    )
  end

  subject do
    described_class.new(
      title: "Test Task",
      description: "This is a valid task description for testing purposes",
      completed: false,
      user: user
    )
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it "is invalid without description" do
      subject.description = nil
      expect(subject).not_to be_valid
    end

    it "is invalid if title is too short" do
      subject.title = "Hi"
      expect(subject).not_to be_valid
    end

    it "is invalid if title is too long" do
      subject.title = "A" * 101
      expect(subject).not_to be_valid
    end

    it "is invalid if description is too short" do
      subject.description = "Short"
      expect(subject).not_to be_valid
    end

    it "belongs to a user" do
      expect(subject.user).to eq(user)
    end
  end

  describe "completion timestamp" do
    it "sets completed_at when marked complete" do
      subject.completed = true
      subject.save

      expect(subject.completed_at).not_to be_nil
    end

    it "clears completed_at when marked incomplete" do
      subject.completed = true
      subject.save

      subject.completed = false
      subject.save

      expect(subject.completed_at).to be_nil
    end
  end
end
