class PetAdoptFormsController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    if pet.adoptable == "Available"
      pet.adoptable = "Pending"
      pet.pending_app = params[:adopt_form_id]
      pet.save
      redirect_to "/pets/#{pet.id}"
    else
      pet.adoptable = "Available"
      redirect_to "/pets/#{pet.id}"
    end
  end

end