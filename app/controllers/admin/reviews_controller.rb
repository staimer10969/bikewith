class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @review = Review.find(params[:id])
    @item = @review.item
    gon.studio = @studio
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_path
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :motive, :merit, :demerit, :advice, :score, :address, :latitude, :longitude)
  end

end
