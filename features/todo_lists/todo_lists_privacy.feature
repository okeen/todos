Feature: Todo list privacy

  In order to hide my todo lists for other users
  As a user
  I want to see all my todo lists
  And I want no other user to access my todos  

  Scenario: Not logged user tries to access his own todo lists
    Given an existing user "user@example.com/secret"
	And I am not logged in
	When I go to my todo lists page
    Then I should see no todo lists
    And I should see "You need to login to manage TODO lists"

 Scenario: Logged user tries to access his own todo lists
    Given an existing user "user@example.com/secret"
	And an existing todo list "list1" with three todos "one,two,three" for user "user@example.com"
    When I log in as "user@example.com" and password "secret"
	And I go to my todo lists page
    Then I should see my todo lists    

 Scenario: Logged user tries to access someone else's todo lists
    Given an existing user "user@example.com/secret"
	And an existing user "alice@example.com/secret"
	When I log in as "user@example.com" and password "secret"   
	And I go to alices todo lists page
	Then I should see no todo lists
    And I should see "These lists are private"
