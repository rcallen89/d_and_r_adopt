class FavoritesController < ApplicationController
  def add_pet
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