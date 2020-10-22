class Public::HomesController < ApplicationController
  before_action :authenticate_participant!, only: [:see_you]

  def about
  end

  def owabi
  end

end
