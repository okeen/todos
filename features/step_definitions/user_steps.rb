Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.diff!(tableish('table tr', 'td,th'))
end

                                                                                                             
Given /^an existing user "([^"]*)"$/ do |email_and_password|
  email,password = email_and_password.split("/")                                                                         
  @user = User.create(:email => email,
                      :password => password)                                                    
end                                                                                                                    
                                                                                                                       
When /^I log in as "([^"]*)" and password "([^"]*)"$/ do |email, password|
  visit sign_in_path
  fill_in 'user[email]', :with => email
  fill_in 'user[password]', :with => password
  click_button 'login'                                                      
end                                                                                                                    
                                                                                                                       
Then /^I should be logged out$/ do                                                                                     
  @user.session.should be_blank                                                    
end                                                                                                                    
                                                                                                                                                                                                                                         
                                                                                                                       
Then /^I should be logged in$/ do                                                                                      
  @user.session.should_not be_blank                                                      
end                                                                                                                    
                                                                                                                       
Given /^a Visitor with no existing account$/ do                                                                        
end

When /^I try to create a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|                            
  fill_in 'user[email]', :with => email
  fill_in 'user[password]', :with => password
  click_button 'sign up'                                                  
end                    