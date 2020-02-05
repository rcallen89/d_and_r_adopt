class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    params.delete_if {|params, value| value.blank?}
    Review.create(review_params)
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :image, :shelter_id)
    end

end