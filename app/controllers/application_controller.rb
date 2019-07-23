class ApplicationController < ActionController::Base

  protect_from_forgery
  force_ssl

  rescue_from 'CanCan::AccessDenied' do |exception|
    #render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
    redirect_to root_path, :alert => exception.message
  end


  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user


end
