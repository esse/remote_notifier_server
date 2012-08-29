class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  def index
    @clients = current_user.clients.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = current_user.clients.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = current_user.clients.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = current_user.clients.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = current_user.clients.new(params[:client])
    @client.token = SecureRandom.hex(24)
    @client.secret = SecureRandom.hex(24)
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = current_user.clients.find(params[:id])
    @client.token = SecureRandom.hex(24)
    @client.secret = SecureRandom.hex(24)
    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = current_user.clients.find(params[:id])
    @client.destroy
    @client.children.each { |x| x.destroy }

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
end
