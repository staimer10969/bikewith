class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    if params[:customer_id]
      @reviews = Review.where(customer_id: params[:customer_id]).page(params[:page]).per(10).order('created_at DESC')
    else
      @reviews = Review.all.page(params[:page]).per(10).order('created_at DESC')
    end
      @tag_list = Tag.all
    # @reviews = Review.all.page(params[:page]).per(10).order('created_at DESC')
  end

  def search
    sort_select = params[:sort_select]
    score = params[:score]
    price = params[:price]
    @reviews = Review.sort(sort_select, score, price).page(params[:page]).per(10)
    #@reviews = Review.all.page(params[:page]).per(10).order('created_at DESC')
    @tag_list = Tag.all
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:review_tag_id])
    @reviews = @tag.reviews.page(params[:page]).per(10)
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :motive, :merit, :demerit, :advice, :score, :store, :address, :latitude, :longitude)
  end

end
