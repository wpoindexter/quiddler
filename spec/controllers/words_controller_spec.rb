require 'rails_helper'
require 'rake'

RSpec.describe WordsController, type: :controller do
  before :all do
    load Rails.root + 'db/seeds.rb'
  end

  after :all do
    Letter.delete_all
  end

  describe 'GET #index' do
    it 'should render all words for a player' do
      player = FactoryGirl.create :player
      FactoryGirl.create_list :word, 4, player: player
      get :index, player_id: player.id, game_id: player.game.id
      expect(response).to be_ok
      expect(JSON.parse(response.body)['words'].size).to eq 4
    end
  end

  describe 'GET #show' do
    it 'should render a word' do
      word = FactoryGirl.create :word
      get :show, id: word.id, player_id: word.player.id, game_id: word.player.game.id
      expect(response).to be_ok
      expect(JSON.parse(response.body)['word']['id']).to eq word.id
    end
  end

  describe 'POST #create' do
    it 'should create a word' do
      player = FactoryGirl.create :player
      expect { post :create, word: { text: 'something' }, player_id: player.id, game_id: player.game.id }.to change(Word, :count).by 1
      expect(JSON.parse(response.body)['word']['id']).to_not be_nil
      expect(JSON.parse(response.body)['word']['text']).to eql 'something'
    end

    it 'should render error if unable to save' do
      player = FactoryGirl.create :player
      allow_any_instance_of(Word).to receive(:save).and_return false
      post :create, word: { text: 'fail' }, player_id: player.id, game_id: player.game.id
      expect(response.code).to eq '422'
    end
  end

  describe 'PUT #update' do
    let(:word) { FactoryGirl.create :word }

    it 'should update a word' do
      put :update, id: word.id, word: { text: 'updated' }, player_id: word.player.id, game_id: word.player.game.id
      expect(JSON.parse(response.body)['word']['text']).to eq 'updated'
    end

    it 'should render error if unable to save' do
      allow_any_instance_of(Word).to receive(:update).and_return false
      put :update, id: word.id, word: { text: 'fail' }, player_id: word.player.id, game_id: word.player.game.id
      expect(response.code).to eq '422'
    end
  end

  describe 'POST #validate' do
    # TODO: for now, only fail if the text is 'fail'
    context 'valid' do
      it 'should render word validity' do
        post :validate, text: 'success'
        expect(JSON.parse(response.body)['valid']).to eq true
      end
    end

    context 'invalid' do
      it 'should render word validity' do
        post :validate, text: 'fail'
        expect(JSON.parse(response.body)['valid']).to eq false
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:word) { FactoryGirl.create :word }

    it 'should delete a word' do
      delete :destroy, id: word.id, player_id: word.player.id, game_id: word.player.game.id
      expect(Word.find_by word.id).to be_nil
    end

    it 'should render error if unable to deactivate a word' do
      allow_any_instance_of(Word).to receive(:destroy).and_return false
      delete :destroy, id: word.id, player_id: word.player.id, game_id: word.player.game.id
      expect(response.code).to eq '422'
    end
  end
end
