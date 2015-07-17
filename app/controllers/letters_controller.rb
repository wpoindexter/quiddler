class LettersController < ApplicationController
  def index
    render json: Letter.all
  end
end
