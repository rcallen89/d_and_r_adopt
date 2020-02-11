class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])

    params.delete :image if ( (params[:image].blank?))
    review = Review.new(review_params)
    if review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:error] = "Please fill in Title, Rating, and Content first!"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])

    params.delete :image if ( (params[:image].blank?) )

    if @review.update(review_params)
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:error] = "Please fill in Title, Rating, and Content first!"
      render :edit
    end
  end

  def destroy
    Review.destroy(params[:review_id])
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :image, :shelter_id)
    end

    def has_asset?(image)
      Rails.application.assets.find_asset(image) == nil
    end

end