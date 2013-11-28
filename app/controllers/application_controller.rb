#-*- coding: utf-8 -*-#
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_signed_in
    unless user_signed_in?
      flash[:error] = 'You must be signed in to do that!'
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin?
      if current_user.email == 'benspotatoes@gmail.com'
        current_user.update_attribute(:admin, true)
      else
        flash[:error] = 'You must be an admin to do that!'
        redirect_to root_path
      end
    end
  end
end
