class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_item, only: [:show, :edit, :update]
  #before_action :ensure_item, only: [:show, :edit, :update]

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
   #@item = Item.find(params[:id])
  end

  def edit
    #@item = Item.find(params[:id])
  end

  def update
    #@item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :brand, :model, :model_year, :engine, :price, :image)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
