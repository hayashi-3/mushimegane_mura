# frozen_string_literal: true

class Organizers::SessionsController < Devise::SessionsController
  def new_guest
    organizer = Organizer.guest
    sign_in organizer
    redirect_to organizers_events_path, notice: 'ゲストユーザーとしてログインしました。'
  end
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
  private
  def after_sign_in_path_for(resource)
    organizers_events_path
  end

  def after_sign_out_path_for(resource)
    new_organizer_session_path
  end
end
