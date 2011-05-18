                                                                                                                       
Given /^an existing TODO list "([^"]*)"$/ do |arg1|                                                                    
  @todo_list = @user.todo_lists.create(:title => arg1)                                                    
end                                                                                                                    
                                                                                                                       
                                                                                                     
When /^I create a new todo with title "([^"]*)" and expected_duration "([^"]*)"$/ do |title, expected_duration|                      
  within "div#new_todo" do
    fill_in 'Title', :with => title
    fill_in 'Expected duration', :with => expected_duration unless expected_duration == 'nil'
    click_button "Add TODO"
  end                                                        
end                                                             

Then /^I should have "([^"]*)" item on the TODO list "([^"]*)"$/ do |todo_count, list_name|                                       
  @todo_list = TodoList.where(:title => list_name).first
  @todo_list.todos.count.should == todo_count.to_i                                                    
end                                                       
                                                                                                                       
Then /^I should see the recently created todo highlighted$/ do                                                         
  pending "Need to get Selenium installed and working with webrat for rich javascript interactions"
  #within "table#todos_table" do
  #   page.should have_selector("tr.new_todo_item")
  #end                                                    
end                                                                                                                    
                                                                 
                                                                                                                      
Then /^I should not see the recently created todo highlighted$/ do                                                     
  page.should_not have_selector("tr.new_todo_item]")                                                    
end                                                     

                                                                                                                    
Given /^the existing todos for "([^"]*)" list:$/ do |list_title, todos_table|                                                      
  @todo_list = TodoList.where(:title => list_title).first
  todos_table.hashes.each do |todo|
    @todo_list.todos.create(todo)  
  end                                          
end                                                                                                                    
                                                                                                                       
When /^I search for "([^"]*)"$/ do |search_term|                                                                              
  #within "#search" do
    fill_in "q", :with => search_term
    click_button "Search"
  #end                                                    
end                                                                                                                    
                                                                                                                       
Then /^the search results should include the "([^"]*)" todo item$/ do |todo_title|                                           
  page.should have_selector("tr.todo_item", :content => todo_title)                                                    
end                                                                                                                    
                                                                                                                       
Then /^I shouldn't see any todo found$/ do                                                                             
  page.should_not have_selector("tr.todo_item")                                                    
end       
                                                                                                                      
Then /^I should see '(\d+)' search results listed$/ do |results_count|                                                          
  page.should have_selector("tr.todo_item", :count => results_count.to_i)                                                    
  #page.should have_selector("tr.todo_item")
end                                                                                                                    
                                                                                                                       
Then /^I should see the "([^"]*)" link$/ do |link_name|
  element_id = link_name == "Next results" ? "next_results" : "previous_results"                                                                      
  page.should have_selector("a##{element_id}")                                                      
end   

When /^I mark the todo item "([^"]*)" as "([^"]*)"$/ do |todo_title, is_finished_text|                                                   
  within "tr.todo_item", :content => todo_title do 
    check "is_finished"
  end                                                      
end                                                                                                                    
                                                                                                                       
Then /^I should see the todo item "([^"]*)" as "([^"]*)"$/ do |todo_title, is_finished_text|                                             
  finished_todo_selector = "tr.todo_item"
  check_box_selector = "input"
  if (is_finished_text == 'finished') 
    finished_todo_selector+=".todo_finished"
    check_box_selector+=" checked" if (is_finished_text == 'finished') 
  end
  
  #page.should have_selector(finished_todo_selector, :content => todo_title) do |tr|
  page.should have_selector(finished_todo_selector) do |tr|
    tr.should have_selector check_box_selector
  end
end  

                                                                                                  
When /^I try to delete the todo item "([^"]*)"$/ do |todo_title|                                                             
  within "tr.todo_item", :content => todo_title do
    click_link "Delete" 
    #FIXME: suddenly webrat doesn't see the OK button...
    #click_button "OK"
  end                                                        
end                    


Then /^I should not see the todo item "([^"]*)"$/ do |todo_title|
  page.should_not have_selector("tr.todo_item", :content => todo_title)
end