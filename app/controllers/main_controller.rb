class MainController < ApplicationController
  def home
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @user = User.find(current_user.id)
      @devices = Device.where("account = ?",@user.id)   
      if @user.auth_key.nil?
        gen_auth_key
      end
    end

#    render :json => @user
  end

  def gen_auth_key

    valid = false
    while !valid
      auth_key = Digest::MD5.hexdigest(@user.email + rand(1000).to_s).upcase
      if User.where("auth_key = ?",auth_key).length == 0
        valid = true
      end
    end
    @user.auth_key = auth_key
    @user.save
  end

end
