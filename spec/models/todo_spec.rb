require 'spec_helper'

describe Todo do
  
  describe "When creating new TODOs" do
    before(:each) do
      @user = User.create(:email => "user@example.com",
                        :password => "password")
      @todo_list = @user.todo_lists.create(:title => 'foo')
      @todo = @todo_list.todos.new(:title => 'title',
                                   :due_date => DateTime.tomorrow,
                                   :expected_duration => 2,
                                   :is_finished => false)
    end
    it "should reject a blank title" do
      @todo.title = ""
      @todo.should_not be_valid
    end
    
    it "should reject a blank expected duration" do
      @todo.expected_duration = nil
      @todo.should_not be_valid
      #@todo.expected_duration = 0
      #@todo.should_not be_valid
    end
    
    it "should create a valid TODO" do
      @todo.should be_valid
    end
    
    it "should be possible to delete finished todos" do
      @todo.save!
      @todo.update_attribute :is_finished , true
      @todo.delete.should_not be_blank
    end
  end    
end