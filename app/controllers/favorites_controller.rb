class FavoritesController < ApplicationController
  def index
    if session[:favorites]
      @favs = Pet.find(session[:favorites].keys)
    else
    end
  end

  def create
    if session[:favorites] && session[:favorites][params[:id].to_s]
      flash[:error] = "Pet Already Favorited"
    elsif session[:favorites]
      session[:favorites][params[:id].to_s] = 0;
      flash[:success] = "Pet added to Favorites"
    else
      session[:favorites] = {}
      session[:favorites][params[:id].to_s] = 0;
      flash[:success] = "Pet added to Favorites"
    end
    redirect_to "/pets/#{params[:id]}"
  end
end