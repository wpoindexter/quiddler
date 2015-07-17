class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :update, :destroy]

  def index
    render json: Player.where(game: params[:game_id])
  end

  def show
    render json: @player
  end

  def create
    player = Player.new player_params
    player.game_id = params[:game_id]
    if player.save
      render json: player, status: :created
    else
      render_error
    end
  end

  def update
    if @player.update player_params
      render json: @player
    else
      render_error
    end
  end

  def destroy
    if @player.destroy
      render nothing: true
    else
      render_error
    end
  end

  private

  def set_player
    @player = Player.find params[:id]
  end

  def player_params
    params.require(:player).permit :name, :scorekeeper
  end

  def render_error
    render json: @player.errors, status: :unprocessable_entity
  end
end
