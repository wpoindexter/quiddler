require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  context 'index' do
    it 'should render all games' do
      games = FactoryGirl.create_list :active_game, 4
      get :index
      expect(response).to be_ok
      expect(JSON.parse(response.body)['games'].size).to eq 4
    end
  end

  context 'show' do
    it 'should render a game' do
      game = FactoryGirl.create :active_game
      get :show, id: game.id
      expect(response).to be_ok
      expect(JSON.parse(response.body)['game']['id']).to eq game.id
    end
  end

  context 'create' do
    it 'should create an active game' do
      post :create, friendly_name: 'Something'

    end
  end
end
