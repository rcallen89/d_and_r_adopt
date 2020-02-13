class ShelterpetsController < ApplicationController
  def index
    @shelter  = Shelter.find(params[:shelter_id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    pet = @shelter.pets.new(pet_params)
    if pet.save
      redirect_to "/shelters/#{@shelter.id}/pets"
    else
      flash[:error] = pet.errors.full_messages.to_sentence
      redirect_to "/shelters/#{@shelter.id}/pets/new"
    end
  end

  private

  def pet_params
    params.permit(:name, :image, :description, :approximate_age, :sex)
  end
end
