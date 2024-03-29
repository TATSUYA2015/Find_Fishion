# frozen_string_literal: true

class PostAdmin::SessionsController < Devise::SessionsController
  before_action :contributor_state, only: [:create]
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
  def contributor_state
    @contributor = Contributor.find_by(email: params[:contributor][:email])
    return if !@contributor
    if @contributor.valid_password?(params[:contributor][:password]) && @contributor.is_deleted
      redirect_to new_contributor_registration_path
    end
  end

end
