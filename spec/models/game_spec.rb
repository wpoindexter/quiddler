require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should have_many :players }

    it 'should destroy players' do
      game = FactoryGirl.create :game
      players = FactoryGirl.create_list :player, 4, game: game
      expect{ game.destroy }.to change { Player.count }.by -4
    end
  end

  describe 'validations' do
    it { should validate_uniqueness_of :friendly_name }
    it { should validate_presence_of :friendly_name }
  end
end
