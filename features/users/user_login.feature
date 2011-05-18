Feature: User Login

  In order to create and watch my todo lists
  As a user
  I want to log in

  Scenario: User does not exist
    Given an existing user "user@example.com/secret"
    When I go to the log in page
    And I log in as "other_user@example.com" and password "secret"
    Then I should see "Invalid email/password"
    And I should be logged out

 Scenario: User tries to log in with wrong password
    Given an existing user "user@example.com/secret"
    When I go to the log in page
    And I log in as "user@example.com" and password "public"
    Then I should see "Invalid email/password"
    And I should be logged out

 Scenario: User logs in successfully
    Given an existing user "user@example.com/secret"
    When I go to the log in page
	And I log in as "user@example.com" and password "secret"
    Then I should see "Welcome user@example.com"
    And I should be logged in
