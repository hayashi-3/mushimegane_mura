# frozen_string_literal: true

class Participants::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_participant, only: [:create]
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

  protected

  def reject_participant
    @participant = Participant.find_by(email: params[:participant][:email].downcase)
    if (@participant.valid_password?(params[:participant][:password]) && (@participant.active_for_authentication? == false))
      flash[:error] = "退会済です。"
      redirect_to new_participant_session_path
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
