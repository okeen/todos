class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :title, :required => true
      t.references :todo_list
      t.datetime :due_date
      t.boolean :is_finished, :default => false
      t.integer :expected_duration, :required => true

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
