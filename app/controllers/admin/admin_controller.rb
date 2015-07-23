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
      @active_games_chart_data = []
      (1.week.ago.to_date..Time.zone.today).map { |date| date.strftime('%b %d') }.each do |date|
        parsed_date = Chronic.parse date
        @active_games_chart_data << { period: date, active_games: Game.where(['created_at >= ? AND created_at <= ?', parsed_date.beginning_of_day, parsed_date.end_of_day]).count }.to_json
      end
      p @active_games_chart_data
    end
  end
end
