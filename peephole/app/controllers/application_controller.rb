class ApplicationController < ActionController::Base
  protect_from_forgery

  def upload_file
    user_visible_upload_path = 'images/userimages'
    uploaded_file_name = ActiveSupport::SecureRandom.hex + params[:upload].original_filename.gsub(/\s/, '')

    user_visible_upload_path = File.join(user_visible_upload_path, uploaded_file_name)
    upload_path = "public/#{user_visible_upload_path}"

    File.open upload_path, "wb" do |f|
      f.write params[:upload].read
    end
    @image_path = "http://#{request.env['SERVER_NAME']}:#{request.env['SERVER_PORT']}/#{user_visible_upload_path}"
  end  
  
  def current_user
    if session[:user].nil? then
      authenticate
    else
      session[:user]
    end
  end

  def authenticate
    if session[:user] then
      return
    end
    if params[:uname] then
      user = User.find_by_login_name params[:uname]
      session[:user] = user
    else
      redirect_to 'http://10.220.2.59/auth/login.aspx'
    end
  end
end
