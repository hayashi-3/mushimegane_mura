require 'rails_helper'

RSpec.describe "ParticipantAuthentications", type: :request do
  let(:participant) { create(:participant) }
  let(:participant_params) { attributes_for(:participant) }
  let(:invalid_participant_params) { attributes_for(:participant, name: "") }

  describe 'POST #create' do
    before do
      ActionMailer::Base.deliveries.clear
    end
    context 'パラメータが妥当な場合' do
      it 'リクエストが成功すること' do
        post participant_registration_path, params: { participant: participant_params }
        expect(response.status).to eq 302
      end

      it 'createが成功すること' do
        expect do
          post participant_registration_path, params: { participant: participant_params }
        end.to change(participant, :count).by 1
      end

      it 'リダイレクトされること' do
        post participant_registration_path, params: { participant: participant_params }
        expect(response).to redirect_to events_path
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功すること' do
        post participant_registration_path, params: { participant: invalid_participant_params }
        expect(response.status).to eq 200
      end

      it 'createが失敗すること' do
        expect do
          post participant_registration_path, params: { participant: invalid_participant_params }
        end.to_not change(participant, :count)
      end

      it 'エラーが表示されること' do
        post participant_registration_path, params: { participant: invalid_participant_params }
        expect(response.body).to include "未入力事項があります。"
      end
    end
  end
end