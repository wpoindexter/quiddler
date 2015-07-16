class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  def index
    render json: Game.all
  end

  def show
    render json: @game
  end

  def create
    @game = Game.new game_params

    respond_to do |format|
      if @game.save
        render :show, status: :created, location: @game
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @game.update game_params
        render :show, status: :ok, location: @game
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @game.destroy
    respond_to do |format|
      head :no_content
    end
  end

  private

  def set_game
    @game = Game.where(friendly_name: params[:id]).first
  end

  def game_params
    params[:game]
  end
end
