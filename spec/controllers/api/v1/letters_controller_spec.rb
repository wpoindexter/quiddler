require 'rails_helper'

RSpec.describe Api::V1::LettersController, type: :controller do
  describe 'GET #index' do
    it 'should render all letters' do
      ('a'..'z').each { |letter| Letter.create(text: letter, points: 1) }
      get :index
      expect(JSON.parse(response.body)['letters'].size).to eq 26
    end
  end
end
