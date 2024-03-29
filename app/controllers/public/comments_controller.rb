class Public::CommentsController < ApplicationController

  def create
    #binding.pry
    @review = Review.find(params[:bike_review_id])
    @comment = current_customer.comments.new(comment_params)
    @comment.review_id = @review.id

    if @comment.save!
       @review.create_notice_comment!(current_customer, @review.id, @comment.id)
       redirect_to bike_review_path(@review.id)
    else
       redirect_to mybike_review_path(@review.id)
    end
  end

  def destroy
    @review = Review.find(params[:bike_review_id])
    @comment = current_customer.comments.find_by(review_id: @review.id)
    @comment.destroy
    redirect_to bike_review_path(@review.id)
    # review = Review.find(params[:bike_review_id])
    # if bike_review.comment.find(params[:id]).destroy
    #   redirect_to bike_review_path(review.id)
    # else
    #   redirect_to mybike_review_path(review.id)
    # end
  end

  private

  def comment_params
    params.permit(:review_comment)
  end

end
