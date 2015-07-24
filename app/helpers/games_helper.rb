module GamesHelper
  def last_game_activated
    games = Game.where(active: true).order('created_at')
    return 'Never' if games.empty?
    "#{distance_of_time_in_words games.last.created_at, Time.zone.now} ago"
  end

  def last_game_deactivated
    games = Game.where(active: false).order('updated_at')
    return 'Never' if games.empty?
    "#{distance_of_time_in_words games.last.updated_at, Time.zone.now} ago"
  end
end
