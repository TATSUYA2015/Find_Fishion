class WebAdmin::CustomersController < ApplicationController
  def index
    @customers=Customer.all
  end

  def show
    @customer=Customer.find(params[:id])
  end

  def edit
    @customer=Customer.find(params[:id])
  end

  def update
    customer=Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to web_admin_customer_path
  end

  def followings
    customer=Customer.find(params[:id])
    @contributors=customer.followings
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :account,:profile_image , :email, :telephone_number, :is_deleted)
  end

end
