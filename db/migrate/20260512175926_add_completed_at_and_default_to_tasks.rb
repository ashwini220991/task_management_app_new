class AddCompletedAtAndDefaultToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :completed_at, :datetime

    change_column_default :tasks, :completed, from: nil, to: false
    change_column_null :tasks, :completed, false
  end
end