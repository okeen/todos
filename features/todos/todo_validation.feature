Feature: Todo items creation and destroy validation

  In order to fill my todo lists with todo items
  As a user
  I want to log in
  And create new todos in existing todo lists

  Scenario: Todo item correctly created
    Given an existing user "user@example.com/secret"
    And an existing TODO list "list1"
    When I log in as "user@example.com" and password "secret"
    And I go to todo_list_list1 page
    And I create a new todo with title "title" and expected_duration "2"
    Then I should see "TODO item added"
    And I should have "1" item on the TODO list "list1"
    And I should see the recently created todo highlighted

  Scenario: Todo item with blank title not allowed
    Given an existing user "user@example.com/secret"
    And an existing TODO list "list1"
    When I log in as "user@example.com" and password "secret"
    And I go to todo_list_list1 page
    And I create a new todo with title "" and expected_duration "2"
    Then I should see "Title can't be blank"
    And I should have "0" item on the TODO list "list1"

  Scenario: Todo item without estimated duration not allowed
    Given an existing user "user@example.com/secret"
    And an existing TODO list "list1"
    When I log in as "user@example.com" and password "secret"
    And I go to todo_list_list1 page
    And I create a new todo with title "title" and expected_duration "nil"
    Then I should see "Expected duration can't be blank"
    And I should have "0" item on the TODO list "list1"


