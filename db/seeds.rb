# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user_a = User.create(:email => "a@a.com", :password => "a")
user_b = User.create(:email => "b@b.com", :password => "b")

todo_list_foo = user_a.todo_lists.create(:title => 'foo')


["title", "compound title", "itle", "nothing", "tle", "compound qitle",
   "uitle", "fitle", "futle", "compound witle", "witle", "ritle"].each_with_index do |title, n|
    todo_list_foo.todos.create(:title => title,
                               :expected_duration => n%5,
                               :due_date => Date.today.beginning_of_day + (n%7).days ,
                               :is_finished => (n%1 == 0)
                             )
end

todo_list_bar = user_a.todo_lists.create(:title => 'bar')

["title", "compound title", "itle", "nothing", "tle", "compound qitle",
   "uitle", "fitle", "futle", "compound witle", "witle", "ritle"].each_with_index do |title, n|
    todo_list_bar.todos.create(:title => title,
                               :expected_duration => n%5,
                               :due_date => Date.today.beginning_of_day + (n%7).days ,
                               :is_finished => (n%1 == 0)
                             )
end
                             

                             
