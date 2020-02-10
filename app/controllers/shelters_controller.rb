class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if shelter.save
      flash[:notice] = "Shelter Created"
      redirect_to '/shelters'
    else
      flash[:notice] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets.any? {|pet| pet.adoptable == "Pending" }
      flash[:notice] = "Can't Delete Shelter with Pending Pet Applications"
      redirect_to "/shelters/#{params[:id]}"
    else
      shelter.pets.destroy_all
      shelter.reviews.destroy_all
      shelter.destroy
      flash[:notice] = "Shelter Deleted"
      redirect_to '/shelters'
    end
  end

  private
    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end
