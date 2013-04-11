class StatusController < ApplicationController
  before_filter :http_api_auth, :device_auth

  def get
    if @device.missing?
      render :text => "", :status => 404
    else
      respond_to do |format|
        format.any {render :template => "status/get.xml.builder", :layout => false, :content_type => "text/xml"}
      end
    end  
  end

  def http_api_auth
    authenticate_or_request_with_http_basic do |auth_key, p|
      users =  User.where("auth_key = ?",auth_key)
      if users.length != 1
        render :text => "", :status => 401
      else
        @user = users.first
      end
    end
  end

  def device_auth
    devices = Device.where("device_id = ?",params[:device_id])
    if devices.length != 1
      head :bad_request
    else
      @device = devices.first
      if @device.account != @user.id
        head :bad_request
      else
        @device = devices.first
      end
    end
  end
end
