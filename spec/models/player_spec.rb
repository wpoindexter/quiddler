require 'rails_helper'

RSpec.describe Player, type: :model do
  describe 'associations' do
    it { should belong_to :game }
    it { should have_many :words }
  end

  describe 'validations' do
    it 'should allow only one scorekeeper per game' do
      game = FactoryGirl.create :game
      player1 = FactoryGirl.create :player, name: 'Player 1', scorekeeper: true, game: game
      player2 = FactoryGirl.create :player, name: 'Player 2', scorekeeper: false, game: game
      player2.update scorekeeper: true
      expect(Player.find_by(player1.id).scorekeeper).to be false
      expect(player2.scorekeeper).to be true
    end

    it 'should not allow duplicate player names per game' do
      game = FactoryGirl.create :game
      player1 = FactoryGirl.create :player, name: 'Player 1', game: game
      player2 = FactoryGirl.create :player, name: 'Player 2', game: game
      player3 = Player.create name: 'Player 1', game: game
      expect(player3.errors.first).to eq [:name, "name already taken"]
    end
  end
end
