Feature: Sign up

  In order use the todo app
  As a User
  I want to sign up

  Scenario: Visitor signs up with invalid email
    Given a Visitor with no existing account
    When I go to the sign up page
    And I try to create a user with email "invalidemail" and password "password"
    Then I should see "User creation error"
    And I should see "Email is invalid"
	
  Scenario: Visitor signs up with blank password
    Given a Visitor with no existing account
    When I go to the sign up page
    And I try to create a user with email "user@example.com" and password "" 
    Then I should see "User creation error"
    Then I should see "Password can't be blank"

  Scenario: Visitor signs up with valid data
    Given a Visitor with no existing account
    When I go to the sign up page
    And I try to create a user with email "user@example.com" and password "password" 
    Then I should see "signed up"
    And I should be on the sign in page
