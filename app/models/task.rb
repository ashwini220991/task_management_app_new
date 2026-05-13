class Task < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            length: { minimum: 3, maximum: 100 }

  validates :description,
            presence: true,
            length: { minimum: 10, maximum: 500 }

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }

  before_save :set_completed_timestamp

  private

  def set_completed_timestamp
    if completed_changed?
      self.completed_at = completed ? Time.current : nil
    end
  end
end