Feature: Mark TODOs as finished and delete if wanted

  In order to manage my completed tasks 
  As a User
  I want to mark my todo tasks as finished and delete them  
	
    Background: Existing user "user@example.com/secret" Logged in and he's got a todo list with title "list1"
      Given an existing user "user@example.com/secret"
      And an existing TODO list "list1"
      And an existing TODO list "list2"
      And the existing todos for "list1" list:
		| title            | expected_duration | due_date | is_finished |
		| "title"          | 1                 |          | false       |
		| "compound title" | 2                 |          | true        |
      When I log in as "user@example.com" and password "secret"
      And I go to todo_list_list1 page

  Scenario: User marks not finished task "title" as finished 
	When I mark the todo item "title" as "finished"
        Then I should see the todo item "title" as "finished"
	
  Scenario: User marks finished task "compound title" as unfinished 
	When I mark the todo item "title" as "unfinished"
        Then I should see the todo item "title" as "unfinished"
	
  Scenario: User deletes finished todo "compound title"
	When I try to delete the todo item "compound title"
	Then I should not see the todo item "compound title"
	And I should see "Todo item deleted"

  Scenario: User deletes unfinished todo "title"
	When I try to delete the todo item "title"
	Then I should see "Todo item not deleted"
	And I should see the todo item "title" as "unfinished"



