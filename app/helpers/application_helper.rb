module ApplicationHelper

  def search_panel
    content_tag :fieldset, :id=>"search" do
      content_tag(:legend, "Search")+
      form_tag(search_path :method => 'get') do |f|
        text_field_tag("q","" ,:size=>16)+
        submit_tag("Search")
      end
    end
  end

  def top_banner_and_menu(user)
    content_tag :div, :id=>'top_container' do 
      content_tag(:div, :id=>'website_title') {"My TODOer"}+
      content_tag(:div, :id=>'menu' ){
      if user.blank? or user.new_record?
          link_to("Login", sign_in_path)+
          link_to("Sign up", sign_up_path)
        else
          #@user|=user.find(session[:user_id])
          link_to("My TODO lists", user_todo_lists_path(user))+
          link_to("New TODO list", new_user_todo_list_path(user))+
          search_panel
        end
        
      }
    end
  end

  def info_panel
    content_tag(:div, :id=>'status', :class =>'content') do
     content_tag(:div, :id=>'error_explanation', :style => 'display:none'){} +
      flash[:notice]
   end
  end
  
end
