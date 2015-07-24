module ChartData
  class ActiveGames
    class << self
      def build_chart_data(start)
        active_games_chart_data = []
        (start.to_date..Time.zone.today).map { |date| date.strftime('%b %d') }.each do |date|
          active_games_chart_data << for_date(date)
        end
        active_games_chart_data
      end

      private

      def for_date(date)
        { period: date, active_games: Game.where(active: true).created_between(Chronic.parse(date)).to_s }
      end
    end
  end
end
