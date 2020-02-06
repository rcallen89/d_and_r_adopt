class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :fav_count, :in_favs

  def fav_count
    if session[:favorites]
      session[:favorites].keys.count 
    else
      0
    end
  end

  def in_favs(id)
    if session[:favorites]
      session[:favorites].include?(id.to_s)
    end
  end
end
