require "rails_helper"

RSpec.describe Participant, type: :model do
  before do
    @participant = build(:participant)
  end

  describe 'バリデーション' do
    it '全て値が設定されていれば、OK' do
      expect(@participant.valid?).to eq(true)
    end

    it 'nicknameが空だとNG' do
      @participant.nickname = ""
      expect(@participant.valid?).to eq(false)
    end

    it 'emailが空だとNG' do
      @participant.email = ""
      expect(@participant.valid?).to eq(false)
    end
  end
end
