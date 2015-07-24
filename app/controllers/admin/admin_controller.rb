module Admin
  class AdminController < ApplicationController
    layout 'admin'

    def dashboard
      setup_dashboard
      render '/admin/dashboard'
    end

    private

    def setup_dashboard
      @active_games_count = Game.where(active: true).count
      @active_players_count = Player.joins(:game).where(games: { active: true }).count
      @active_words_count = Word.joins(player: :game).where(games: { active: true }).count
      @active_games_chart_data = ChartData::ActiveGames.build_chart_data 1.week.ago
      @word_verifications_count = WordVerification.count
    end
  end
end
