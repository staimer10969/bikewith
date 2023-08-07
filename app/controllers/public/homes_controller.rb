class Public::HomesController < ApplicationController

  def top
    @reviews = Review.all
    @reviews = Review.order('id DESC').limit(10)
  end

  def about
  end

end
