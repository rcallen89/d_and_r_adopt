class FavoritesController < ApplicationController
  def index
    if session[:favorites]
      @favs = Pet.find(session[:favorites].keys)
    else
    end
  end

  def create
    if session[:favorites]
      session[:favorites][params[:id].to_s] = Pet.find(params[:id]).name;
      flash[:success] = "Pet added to Favorites"
    else
      session[:favorites] = {}
      session[:favorites][params[:id].to_s] = Pet.find(params[:id]).name;
      flash[:success] = "Pet added to Favorites"
    end
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    session[:favorites].delete(params[:id])
    flash[:success] = "Pet Removed from Favorites"
    redirect_back(fallback_location: '/favorites')
  end

  def destroy_all
    session[:favorites] = {}
    redirect_to '/favorites'
  end
end
