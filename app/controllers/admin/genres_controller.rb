class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_genre, only: [:edit, :update]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
  end

  def update
    @genre = Genre.find(params[:id])
    @genre.update(genre_params)
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end

  def ensure_genre
    @genre = Genre.find(params[:id])
  end
end
