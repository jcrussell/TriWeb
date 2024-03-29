module SiteMessageHelper

  def render_messages
    conditions = user_signed_in? ? {} : {:internal => 'f'}
    messages = SiteMessage.find(:all, :conditions => conditions, :order => "created_at desc", :limit => 10)

    messages.collect {|message| render(:partial => "partials/site_message", :object => message)}.join("").html_safe
  end
end
