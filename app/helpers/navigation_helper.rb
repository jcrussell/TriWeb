module NavigationHelper
  # Renders navigation for the site
  def render_navigation
    rendered = ["<ul class='dropdown'>"]

    create_navigation.each do |name,items|
      rendered << "<li>"
      rendered << render(:partial => "partials/nav_item", :object => {:name => name, :items => items})
      rendered << "</li>"
    end

    rendered << "</ul>"

    render :inline => rendered.join("")
  end

  private

  # Navigation is in the following format:
  # Name is only admissible when there is only one element in the group
  # Static pages can provide only their name and the path will be figure out
  # {
  #   <Group Name> => [[<path>, <name>], [<static page>]...]
  #   ...
  # }
  def create_navigation
    nav = {
      APP_CONFIG['title_nick'] => [:about, :officers, :sponsors],
      "workouts" => [
        page_link("/calendar", :index, "calendar"),
        :swim, :bike, :run, :brick
      ],
      "help" => [:faqs, :links]
    }
    if user_signed_in?
      nav["tools"] = []
      nav["tools"] << page_link("/admin/roles", :index, "manage user roles") if current_user.has_role? 'admin'
      nav["tools"] << page_link("/admin/site_messages", :new, "create site message") if current_user.has_role? 'admin'
      nav["tools"] << page_link("/devise/registrations", :edit, "update info")
      nav["tools"] << page_link("/devise/sessions", :destroy, "logout", "delete")
    else
      nav["login"] = [
        page_link("/devise/sessions", :create)
      ]
    end

    nav
  end

  def page_link(controller, action, name = nil, method = nil)
    {:controller => controller, :action => action, :name => name, :method => method}.select {|k,v| !v.nil? }
  end

  def static_page_link(name)
    page_link("/static", name)
  end
end
