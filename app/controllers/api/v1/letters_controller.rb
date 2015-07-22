module Api
  module V1
    class LettersController < Api::BaseController
      def index
        render json: Letter.all
      end
    end
  end
end
