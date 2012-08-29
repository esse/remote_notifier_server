class Api::V1::NotificationsController < ApplicationController
  before_filter :authorize_api_client
  
=begin
  # GET /notifications
  # GET /notifications.json
  def index
    @notifications = @client.notifications.all

    respond_to do |format|
      format.json { render json: @notifications }
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = @client.notifications.find(params[:id])

    respond_to do |format|
      format.json { render json: @notification }
    end
  end
=end

  # POST /notifications
  # POST /notifications.json
  def create
    parent_notifications = @client.notifications.where(:message => params[:notification][:message]).
      where(:msg_class => params[:notification][:msg_class]).where(:ancestry => nil)
    parent_notification = parent_notifications.find { |notif| notif.backtrace == params[:notification][:backtrace] }
    if parent_notification
      @notification = parent_notification.children.new(params[:notification])
      @notification.client_id = @client.id
      parent_notification.update_attribute(:solved, false)
    else
      @notification = @client.notifications.new(params[:notification])
    end
    respond_to do |format|
      if @notification.save
        format.json { render json: @notification, status: :created }
      else
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end
  
protected
  
  def authorize_api_client
    authenticate_or_request_with_http_basic do |username, password|
      @client = Client.where(:token => username).where(:secret => password).first
      !!@client
    end
  end

end
