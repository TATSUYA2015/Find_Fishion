# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  protected
  def customer_state
    if params[:customer][:email]
      @customer = Customer.find_by(email: params[:customer][:email])
      return if !@customer
      if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
        redirect_to new_customer_registration_path
      end
    elsif params[:customer][:uid]
      @customer = Customer.find_by(uid: params[:customer][:uid])
      return if !@customer
      if @customer.valid_provider?(params[:customer][:provider]) && @customer.is_deleted
        redirect_to new_customer_registration_path
      end
    end
  end
end
