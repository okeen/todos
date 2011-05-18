Given /^I am not logged in$/ do                                                                                        
end                                                                                                                    
                                                                                                                       
Then /^I should see no todo lists$/ do                                                                                 
  page.should_not have_content("My TODO Lists:")
  page.should_not have_selector("div[id='todo_lists_list']")                                                    
end  
                                                                                                                       
Then /^I should see my todo lists$/ do                                                                                 
  page.should have_content("My TODO Lists:")
  page.should have_selector("div[id='todo_lists_list']")                                                      
end         

Given /^an existing todo list "([^"]*)" with three todos "([^"]*)" for user "([^"]*)"$/ do |todo_list_title, todo_items_titles, user_email|          
  @user = User.where(:email => user_email).first
  @todo_list = @user.todo_lists.create(:title => todo_list_title)
  todo_items_titles.split.each do |title|
    @todo_list.todos.create(:title => title)
  end
                                                          
end 