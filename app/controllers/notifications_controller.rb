class NotificationsController < ApplicationController
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = current_user.find_client(params[:client_id]).notifications.root.page(params[:page] || 1)

    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def toggle
    current_user.find_client(params[:client_id]).notifications.find(params[:notification_id]).toggle!
    redirect_to :back
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = current_user.find_client(params[:client_id]).notifications.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end


  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    client = current_user.find_client(params[:client_id])
    @notification = client.notifications.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to client_notifications_url(client) }
    end
  end
end
