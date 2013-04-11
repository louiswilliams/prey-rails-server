class DevicesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_owner?, :except => [ :index, :create, :new ]
  before_filter :exists?, :except => [ :index, :create, :new ]

  def is_owner?
    if current_user.id != Device.find(params[:id]).account
      redirect_to root_path
    end
  end

  def exists?
    unless @device = Device.find(params[:id])
      redirect_to root_path
    end
  end

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.where("account = ?",current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devices }
    end
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/new
  # GET /devices/new.json
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(params[:device])

    @device.account = current_user.id
    @device.device_id = Digest::MD5.hexdigest(current_user.email + @device.name + rand(1000).to_s).to_i(16).to_s(10)[0..9]

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render json: @device, status: :created, location: @device }
      else
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.json
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end
end
