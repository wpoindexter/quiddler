class WordsController < ApplicationController
  before_action :set_word, only: [:show, :update, :destroy]

  def index
    render json: Word.where(player: params[:player_id])
  end

  def show
    render json: @word
  end

  def create
    @word = Word.new word_params
    if @word.save
      render :show, status: :created, location: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  def update
    if @word.update word_params
      render :show, status: :ok, location: @word
    else
      render json: @word.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @word.destroy
    head :no_content
  end

  private

  def set_word
    @word = Word.find params[:id]
  end

  def word_params
    params[:word]
  end
end
