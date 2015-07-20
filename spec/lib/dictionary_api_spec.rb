require 'rails_helper'
require_relative '../../lib/dictionary_api.rb'

RSpec.describe DictionaryApi do
  context 'word_exists?' do
    it 'should be callable' do
      DictionaryApi.word_exists? 'blabla'
    end
  end
end
