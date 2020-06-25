class PagesController < ApplicationController

  #if the user is logged in, clicking home page will redirect to users recipes listing instead
  # of home page
  def home
    redirect_to recipes_path if logged_in?
  end
end
