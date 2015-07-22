module Api
  module V1
    class GamesController < Api::BaseController
      before_action :set_game, only: [:show, :update, :destroy]

      def index
        render json: Game.all
      end

      def show
        render json: @game
      end

      def create
        @game = Game.new game_params
        @game.active = true
        if @game.save
          render json: @game, status: :created
        else
          render_error
        end
      end

      def update
        if @game.update game_params
          render json: @game
        else
          render_error
        end
      end

      def destroy
        if @game.update_attribute :active, false
          render json: @game
        else
          render_error
        end
      end

      private

      def set_game
        @game = Game.find params[:id]
      end

      def game_params
        params.require(:game).permit :active, :friendly_name
      end

      def render_error
        render json: @game.errors, status: :unprocessable_entity
      end
    end
  end
end
