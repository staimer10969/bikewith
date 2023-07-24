class Public::LikesController < ApplicationController

  def create
    @review = Review.find(params[:bike_review_id])
    @like = current_customer.likes.new(review_id: @review.id)
    @like.save
    redirect_to bike_review_path(@review.id)
  end

  def destroy
    @review = Review.find(params[:bike_review_id])
    @like = current_customer.likes.find_by(review_id: @review.id)
    @like.destroy
    redirect_to bike_review_path(@review.id)
  end

end
