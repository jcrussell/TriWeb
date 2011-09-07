class Admin::SiteMessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :admin_required

  # GET /site_messages/new
  def new
    @site_message = SiteMessage.new
  end

  # GET /site_messages/1/edit
  def edit
    @site_message = SiteMessage.find(params[:id])
  end

  # POST /site_messages
  def create
    @site_message = current_user.site_messages.build(params[:site_message])

    if @site_message.save
      redirect_to(root_path, :notice => 'Message was created successfully.')
    else
      render :action => "new"
    end
  end

  # PUT /site_messages/1
  def update
    @site_message = SiteMessage.find(params[:id])

    if @site_message.update_attributes(params[:site_message])
      redirect_to(root_path, :notice => 'Message was updated successfully.')
    else
      render :action => "edit"
    end
  end

  # DELETE /site_messages/1
  def destroy
    @site_message = SiteMessage.find(params[:id])

    @site_message.destroy
    redirect_to(root_path, :notice => 'Message removed successfully')
  end
end
