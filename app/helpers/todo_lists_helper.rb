module TodoListsHelper
  def remaining_todos_work_estimation(user)
    unfinished_tasks = user.todos.unfinished
    total_duration = unfinished_tasks.collect(&:expected_duration).sum
    "#{unfinished_tasks.count} TODO task(s) to complete yet, Estimated total time: #{total_duration}"
  end
end
