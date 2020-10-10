class Public::HomesController < ApplicationController
  before_action :authenticate_participant!, only: [:see_you]

  def about
  end

  def see_you
  end

end
