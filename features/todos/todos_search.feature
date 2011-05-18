Feature: Todos searching

  In order to easily manage my todos
  As a User
  I want to search by its title's content and receive 10 max results per page  
	
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
      And the existing todos for "list2" list:
		| title            | expected_duration | due_date | is_finished |
		| "tle"            | 1                 |          | false       |
		| "compound qitle" | 2                 |          | true        |
		| "uitle"          | 3                 |          | false       |
		| "fitle"          | 4                 |          | false       |
		| "futle"          | 1                 |          | false       |
		| "compound witle" | 2                 |          | true        |
		| "witle"          | 3                 |          | false       |
		| "ritle"          | 4                 |          | false       |

      When I log in as "user@example.com" and password "secret"


  Scenario: User searches for item with title "title" 
    When I search for "title"
    Then I should see "2 result(s) found:"
    And the search results should include the "title" todo item
    And the search results should include the "compound title" todo item
	
  Scenario: User searches for item with title "thing" 
    When I search for "nothing"
    Then I should see "1 result(s) found:"
    And the search results should include the "nothing" todo item
	
  Scenario: User searches for item with title "foobar" 
    When I search for "foobar"
    Then I should see "0 result(s) found:"
    And I shouldn't see any todo found
  
  Scenario: User searches for item with title "tle" and navigates through result pages 
    When I search for "tle"
    Then I should see "11 result(s) found:"
    And I should see '10' search results listed
    And I should see the "Next results" link
