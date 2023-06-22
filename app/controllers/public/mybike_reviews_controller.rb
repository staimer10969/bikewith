class Public::MybikeReviewsController < ApplicationController
  before_action :authenticate_customer!

  def new

  end

  def cleate
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def mybikereview_params
    params.require(:mybikereview).permit(:comment, :score, :address, :latitude, :longitude)
  end
end
