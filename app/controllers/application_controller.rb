class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :fav_count

  def fav_count
    if session[:favorites]
      session[:favorites].keys.count 
    else
      0
    end
  end
end
