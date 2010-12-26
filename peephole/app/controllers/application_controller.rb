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
    if session[:user_id].nil? then
      User.all.first
    else
      User.find(session[:user_id])
    end
  end

  def authenticate
# Cut out this crap and try to use some form of Active Directory authentication instead
# Maybe internally redirect to an IIS Server, get the credentials authenticated 
    unless User.all.any?
      user1 = User.new
      user1.name = 'skselvaraj'
      user1.full_name = 'Senthil Kumar Selvaraj'
      user1.save!
      user2 = User.new
      user2.name = 'sounderarajan.d'
      user2.full_name = 'Soundararajan Dakshinamoorthy'
      user2.save!
    end
    session[:user_id] = User.all.first.id
  end
end
