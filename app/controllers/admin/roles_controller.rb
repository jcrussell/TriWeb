class Admin::RolesController < ApplicationController
  before_filter :admin_required

  # GET /admin/roles/index
  def index
    @users = User.all
    @roles = User::ROLES_MASK
    @num_roles = @roles.size
  end

  # POST /admin/roles/update
  def update
    User.find(:all).each do |user|
      updates = params[:user][user.to_param]
      User::ROLES_MASK.each do |role|
        if updates.nil? || updates[role] != "yes"
          user.remove_role role
        else
          user.add_role role
        end
      end
      user.save
    end

    redirect_to(admin_roles_index_path, :notice => "Updated roles successfully.")
  end
end
