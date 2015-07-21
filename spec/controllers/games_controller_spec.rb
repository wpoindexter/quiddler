require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'GET #index' do
    it 'should render all games' do
      FactoryGirl.create_list :active_game, 4
      get :index
      expect(response).to be_ok
      expect(JSON.parse(response.body)['games'].size).to eq 4
    end
  end

  describe 'GET #show' do
    it 'should render a game' do
      game = FactoryGirl.create :active_game
      get :show, id: game.id
      expect(response).to be_ok
      expect(JSON.parse(response.body)['game']['id']).to eq game.id
    end
  end

  describe 'POST #create' do
    it 'should create an active game' do
      expect { post :create, game: { friendly_name: 'Something' } }.to change(Game, :count).by 1
      expect(JSON.parse(response.body)['game']['id']).to_not be_nil
      expect(JSON.parse(response.body)['game']['friendly_name']).to eql 'Something'
    end

    it 'should require a friendly name' do
      post :create, game: { active: true }
      expect(response.code).to eq '422'
    end
  end

  describe 'PUT #update' do
    let(:game) { FactoryGirl.create :active_game }

    it 'should update a game' do
      put :update, id: game.id, game: { active: false }
      expect(JSON.parse(response.body)['game']['active']).to eq false
    end

    it 'should require a friendly name' do
      put :update, id: game.id, game: { friendly_name: nil }
      expect(response.code).to eq '422'
    end
  end

  describe 'DELETE #destroy' do
    let(:game) { FactoryGirl.create :active_game }

    it 'should deactivate a game' do
      delete :destroy, id: game.id
      expect(Game.find(game.id).active).to eq false
    end

    it 'should render error if unable to deactivate a game' do
      allow_any_instance_of(Game).to receive(:save).and_return false
      delete :destroy, id: game.id
      expect(response.code).to eq '422'
    end
  end
end
