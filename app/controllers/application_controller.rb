class ApplicationController < ActionController::Base
  protect_from_forgery

  def admin_required
    unless user_signed_in? && current_user.is_admin?
      flash[:alert] = "Sorry, insufficient privileges."
      redirect_to root_url and return false
    end
  end
end
