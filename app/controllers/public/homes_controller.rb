class Public::HomesController < ApplicationController
  before_action :authenticate_participant!, only: [:owabi]

  def about
  end

  def owabi
  end

end
