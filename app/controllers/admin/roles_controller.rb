class Admin::RolesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_required

  # GET /admin/roles/index
  def index
    @users = User.all
    @roles = User::ROLES_MASK
    @num_roles = @roles.size
  end

  # POST /admin/roles/update
  def update
    # If the user params are empty, probably means that the admin unchecked all the checkboxes
    params[:user] ||= {}
    User.find(:all).each do |user|
      updates = params[:user][user.to_param]
      User::ROLES_MASK.each do |role|
        if updates.nil? || updates[role] != "yes"
          # Shouldn't be able to remove own admin role
          if user != current_user || role != "admin"
            user.remove_role role
          else
            flash[:alert] = "Cannot remove admin role from yourself. Will continue to update other users."
          end
        else
          user.add_role role
        end
      end
      user.save
    end

    redirect_to(admin_roles_index_path, :notice => "Roles were updated successfully.")
  end
end
