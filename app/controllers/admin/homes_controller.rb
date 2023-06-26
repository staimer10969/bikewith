class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @reviews = Review.all.page(params[:page]).per(10).order('created_at DESC')
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :motive, :merit, :demerit, :advice, :score, :address, :latitude, :longitude)
  end

end
