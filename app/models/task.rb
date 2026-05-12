# Task model represents a user task
# Each task belongs to a user
# Tasks can be marked completed or pending

class Task < ApplicationRecord
  belongs_to :user

  validates :title, presence: true

  attribute :completed, :boolean, default: false
end
