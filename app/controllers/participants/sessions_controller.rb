# frozen_string_literal: true

class Participants::SessionsController < Devise::SessionsController
  # before_action :guest_user

  def new_guest
    participant = Participant.guest
    sign_in participant
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # def guest_user
  #   @participant = Participant.find_by(email: 'guest@example.com')
  #   if @participant == current_participant
  #     flash[:notice] = 'ゲストユーザーは編集が出来ません'
  #     redirect_to root_path
  #   end
  # end

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
    events_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
