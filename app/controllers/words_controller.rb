class WordsController < ApplicationController
  before_action :set_word, only: [:show, :update, :destroy]

  def index
    render json: Word.where(player: params[:player_id])
  end

  def show
    render json: @word
  end

  def create
    word = Word.new word_params
    word.player_id = params[:player_id]
    if word.save
      render json: word, status: :created
    else
      render_error
    end
  end

  def update
    if @word.update word_params
      render json: @word
    else
      render_error
    end
  end

  def validate
    render json: {valid: Word.new(text: params[:text]).valid_word?}
  end

  def destroy
    if @word.destroy
      render nothing: true
    else
      render_error
    end
  end

  private

  def set_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :text
  end

  def render_error
    render json: @word.errors, status: :unprocessable_entity
  end
end
