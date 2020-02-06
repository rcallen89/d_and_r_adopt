class AdoptFormsController < ApplicationController

  def new
    @favorites = session[:favorites]
  end

  def create
    params[:pets][:pet_id].delete_if {|id| id.blank? }
    form = AdoptForm.new(adopt_form_parms)

    if form.save
      pet_ids = params[:pets][:pet_id]
      pets_objects = Pet.find(params[:pets][:pet_id])
      form.pets << pets_objects
      pet_ids.each {|id| session[:favorites].delete(id)}
      flash[:notice] = "Application Submitted"
      redirect_to '/favorites'
    else
      flash[:error] = "Form Not Complete Try Again"
      render :new
    end
  end

  private

    def adopt_form_parms
      params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
    end

end