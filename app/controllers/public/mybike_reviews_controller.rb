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
    @review.save!
    redirect_to mybike_review_path(@review.id)
    # tag_list = params[:review][:name].split(',')
    # if @review.save
    #   @review.save_reviewtags(tag_list)

    # else
    #   render :new
    # end

  end

  def index
    #if params[:format]
      @reviews = current_customer.reviews.all.page(params[:page]).per(10).order('created_at DESC')
    #else
      #@reviews = Review.all.customer.page(params[:page]).per(10).order('created_at DESC')
    #end
    @tag_list = ReviewTag.all
  end

  def show
    @item = @review.item
    @comment = Comment.new
    @comment = @review.comments
    gon.review = @review
    @tag_list = @review.review_tags.pluck(:name).join(',')
    @review_tags = @review.review_tags
  end

  def edit
    #@item = @review.item
    @tag_list = @review.reviewtags.pluck(:name).join(',')
  end

  def update
    tag_list=params[:review][:name].split(',')
    if @review.update(review_params)
      @review.save_reviewtags(tag_list)
      redirect_to mybike_review_path(@review.id)
    else
      render 'edit'
    end
  end

  def destroy
    current_customer.reviews.find(params[:id]).destroy
    redirect_to customers_information_path(current_customer)
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = ReviewTag.all
    　#検索されたタグを受け取る
    @tag = ReviewTag.find(params[:reviewtag_id])
    　#検索されたタグに紐づく投稿を表示
    @reviews = @tag.reviews
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :motive, :merit, :demerit, :advice, :score, :store, :address, :latitude, :longitude)
  end

  def tag_list_params
    params.require(:tag_list).permit(:name)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
