require 'rails_helper'

RSpec.describe Api::V1::PlayersController, type: :controller do
  describe 'GET #index' do
    it 'should render all players for a game' do
      game = FactoryGirl.create :game
      FactoryGirl.create_list :player, 4, game: game
      get :index, game_id: game.id
      expect(response).to be_ok
      expect(JSON.parse(response.body)['players'].size).to eq 4
    end
  end

  describe 'GET #show' do
    it 'should render a player' do
      player = FactoryGirl.create :player
      get :show, id: player.id, game_id: player.game.id
      expect(response).to be_ok
      expect(JSON.parse(response.body)['player']['id']).to eq player.id
    end
  end

  describe 'POST #create' do
    it 'should create a player' do
      game = FactoryGirl.create :game
      expect { post :create, player: { name: 'Jimmy Butler' }, game_id: game.id }.to change(Player, :count).by 1
      expect(JSON.parse(response.body)['player']['id']).to_not be_nil
      expect(JSON.parse(response.body)['player']['name']).to eql 'Jimmy Butler'
    end

    it 'should render error if unable to save' do
      game = FactoryGirl.create :game
      allow_any_instance_of(Player).to receive(:save).and_return false
      post :create, player: { name: 'Derrick Rose' }, game_id: game.id
      expect(response.code).to eq '422'
    end
  end

  describe 'PUT #update' do
    let(:player) { FactoryGirl.create :player }

    it 'should update a player' do
      put :update, id: player.id, player: { name: 'Joakim Noah' }, game_id: player.game.id
      expect(JSON.parse(response.body)['player']['name']).to eq 'Joakim Noah'
    end

    it 'should render error if unable to save' do
      allow_any_instance_of(Player).to receive(:update).and_return false
      put :update, id: player.id, player: { name: 'Scottie Pippen' }, game_id: player.game.id
      expect(response.code).to eq '422'
    end
  end

  describe 'DELETE #destroy' do
    let(:player) { FactoryGirl.create :player }

    it 'should delete a word' do
      delete :destroy, id: player.id, game_id: player.game.id
      expect(Player.find_by player.id).to be_nil
    end

    it 'should render error if unable to delete a player' do
      allow_any_instance_of(Player).to receive(:destroy).and_return false
      delete :destroy, id: player.id, game_id: player.game.id
      expect(response.code).to eq '422'
    end
  end
end
