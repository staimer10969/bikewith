class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!
   before_action :set_customer, only: [:show, :edit, :update, :confirm_withdraw, :withdraw]

  def show
    if params[:format]
    #@customer = current_customer
      @customer = Customer.find(params[:format])
    end
  end

  def edit
    #@customer = current_customer
  end

  def update
    #@customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_information_path(@customer.id)
    else
      render 'edit'
    end
  end

  def confirm_withdraw
    #@customer = current_customer
  end

  def withdraw
    #@customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


  private

  def customer_params
    params.require(:customer).permit(:name, :skill, :frequency, :introduction, :image)
  end

  def set_customer
    @customer = current_customer
  end

end
