Feature: Todos searching

  In order to have a general view of my remaining work
  As a User
  I want to see stats about how many TODO tasks I have left and how much time will they take me.
	
    Background: Existing user "user@example.com/secret" Logged in and he's got a todo list with title "list1"
      Given an existing user "user@example.com/secret"
      And an existing TODO list "list1"
      And an existing TODO list "list2"
      And the existing todos for "list1" list:
		| title            | expected_duration | due_date | is_finished |
		| "title"          | 1                 |          | false       |
		| "compound title" | 2                 |          | true        |
		| "nothing"        | 3                 |          | false       |
		| "itle"           | 4                 |          | false       |
      
      When I log in as "user@example.com" and password "secret"
      And I go to my todo lists page


  Scenario: User with 3 unfinished tasks sees his todo_lists page
    Then I should see "3 TODO task(s) to complete yet"
    And I should see "Estimated total time: 8"
	
@wip
  Scenario: User with 9 unfinished tasks sees his todo_lists page
    Given the existing todos for "list2" list:
		| title            | expected_duration | due_date | is_finished |
		| "tle"            | 1                 |          | false       |
		| "compound qitle" | 2                 |          | true        |
		| "uitle"          | 3                 |          | false       |
		| "fitle"          | 4                 |          | false       |
		| "futle"          | 1                 |          | false       |
		| "compound witle" | 2                 |          | true        |
		| "witle"          | 3                 |          | false       |
		| "ritle"          | 4                 |          | false       |
    Then I should see "9 TODO task(s) to complete yet"
    And I should see "Estimated total time: 24"
