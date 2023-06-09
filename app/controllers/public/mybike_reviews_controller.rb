class Public::MybikeReviewsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_review, only: [:show, :edit, :update]

  def new
    @review = Review.new
    @customer = current_customer
  end

  def create
    @item = Item.find(review_params[:item_id])
    @review = Review.new(review_params)
    @review.customer_id = current_customer.id
    @review.save
    redirect_to mybike_review_path(@review.id)
  end

  def index
    @reviews = current_customer.reviews.all.page(params[:page]).per(10).order('created_at DESC')
  end

  def show
    @item = @review.item
  end

  def edit
    #@item = @review.item
  end

  def update
    if @review.update(review_params)
      redirect_to mybike_review_path(@review.id)
    else
      render 'edit'
    end
  end

  def destroy
    current_customer.reviews.find(params[:id]).destroy
    redirect_to customers_information_path(current_customer)
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :motive, :merit, :demerit, :advice, :score, :address, :latitude, :longitude)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
