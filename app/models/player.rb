class Player < ActiveRecord::Base
  belongs_to :game
  has_many :words, dependent: :destroy
  validate :only_one_scorekeeper, :unique_player_names_per_game

  private

  def only_one_scorekeeper
    update_non_scorekeepers if scorekeeper && !new_record?
  end

  def update_non_scorekeepers
    game.players.where.not(id: id).each do |player|
      player.update_attribute :scorekeeper, false
    end
  end

  def unique_player_names_per_game
    game.players.where.not(id: id).each do |player|
      errors.add(:name, 'name already taken') if player.name.casecmp(name) == 0
    end
  end
end
