module TodosHelper
  
  def todo_error_message(todo)
    html= pluralize(todo.errors.count, " error")+" prohibited this Todo from being saved:\n"
    todo.errors.full_messages.each do |msg|
      html+= " >" + (msg.to_s) +"\n"
    end
  end

  #TODO implementation
  def todo_is_finished_checkbox(todo)
    check_box_tag :is_finished, 1, todo.is_finished?,
               :onclick => "update_todo_is_finished(#{todo.todo_list.id},#{todo.id},arguments[0].target, arguments[0].target.checked)"
  end

  def next_results_link(todos)
    link_to("Next results", search_path + "?q=#{params[:q]}&page=#{todos.current_page.next}", :id => "next_results")
  end
  
  def previous_results_link(todos)
    link_to("Previous results", search_path + "?q=#{params[:q]}&page=#{todos.current_page-1}", :id => "previous_results")
  end

  def delete_todo_link(todo)
    link_to_function("Delete",
            "remove_todo_item_from_list(arguments[0].target, '#{todo_list_todo_path(todo.todo_list, todo, :format => :js)}');"
     )
  end
end
