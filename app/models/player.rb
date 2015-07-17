class Player < ActiveRecord::Base
  belongs_to :game
  has_many :words, dependent: :destroy

  # validate unique name of players per game

  def set_scorekeeper(scorekeeper)
    if scorekeeper.to_b
      game.players.where.not(id: id).each do |player|
        player.update_attribute :scorekeeper, false
      end
    end
  end
end
