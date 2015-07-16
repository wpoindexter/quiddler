class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  def index
    render json: Player.where(game: params[:game_id])
  end

  def show
    render json: @player
  end

  def create
    @player = Player.new player_params
    if @player.save
      render :show, status: :created, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def update
    if @player.update player_params
      render :show, status: :ok, location: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    head :no_content
  end

  private

  def set_player
    @player = Player.find params[:id]
  end

  def player_params
    params[:player]
  end
end
