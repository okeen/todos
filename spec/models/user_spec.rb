require 'spec_helper'

describe User do
  describe "When signing up" do
    before(:each) do
      @user = User.new(:email => "user@example.com",
                        :password => "password")
    end
    it "should reject a blank password" do
      @user.password = ""
      @user.should_not be_valid
    end
    it "should reject an invalid email" do
      @user.email = "@example.com"
      @user.should_not be_valid
      @user.email = "user@example.com."
      @user.should_not be_valid
      @user.email = "user@example"
      @user.should_not be_valid
      @user.email = "userexample.com"
      @user.should_not be_valid      
    end
    it "should create a valid user" do
      @user.should be_valid
    end
    
  end  
  
  
end