#-*- coding: utf-8 -*-#
class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to search_path
    end
  end

  def about
  end
end
