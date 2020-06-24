class ApplicationController < ActionController::Base

  protect_from_forgery wtih: :exception

  #declare helper methods
  helper_method :current_chef, :logged_in

  #return the chef who is logged in
  def current_chef
    # if chef was already looked for, then return right away, if not, then hit database
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_if]
  end

  #check if anyone logged in
  def logged_in?
    #bang bang turns any expression into true or false
    !!current_chef
  end

  #used for restricting actions based on whether user logged in or not
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end

end
