module ApplicationHelper

  # Creates navigation for the site
  def create_navigation
    # Navigation is in the following format:
    # {
    #   <Group Name> => [[<controller>, <action>, [name]], ...]
    #   ...
    # }
    # Name is optional, will default to the name of the action if not provided
    #
    nav = {
      APP_CONFIG['title_nick'] => [
        {:controller => "/static", :action => "about"},
        {:controller => "/static", :action => "officers"},
        {:controller => "/static", :action => "sponsors"}
      ],
      "workouts" => [
        {:controller => "/calendar", :action => "index", :name => "calendar"},
        {:controller => "/static", :action => "swim"},
        {:controller => "/static", :action => "bike"},
        {:controller => "/static", :action => "run"},
        {:controller => "/static", :action => "brick"}
      ],
      "help" => [
        {:controller => "/static", :action => "faqs"},
        {:controller => "/static", :action => "links"}
      ]
    }
    if user_signed_in?
      nav["tools"] = [
        {:controller => "/devise/registrations", :action => "edit", :name => "update user"},
        {:controller => "/devise/sessions", :action => "destroy", :name => "logout", :method => :delete}
      ]
    else
      nav["login"] = [
        {:controller => "/devise/sessions", :action => "new"}
      ]
    end

    nav
  end

  def get_nav_name(val)
    (val[:name].nil?) ? val[:action] : val.delete(:name)
  end
end
