class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    if !pending?(Pet.find(params[:id]))
      Pet.destroy(params[:id])
      check_favs
      redirect_to '/pets'
    else
      flash[:error] = "Cannot Delete a Pet with an Approved Application"
      redirect_back(fallback_location: "/pets/#{params[:id]}")
    end
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex)
  end

  def pending? pet
    pet.adoptable == "Pending"
  end

  def check_favs
    if session[:favorites] && session[:favorites][params[:id]]
      session[:favorites].delete(params[:id])
    end
  end
end