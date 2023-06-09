class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    #@customer = Customer.find(params[:id])
  end

  def edit
    #@customer = Customer.find(params[:id])
  end

  def update
    #@customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path
    else
      render 'edit'
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
