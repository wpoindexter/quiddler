require 'rails_helper'

RSpec.describe Word, type: :model do
  describe 'associations' do
    it { should belong_to :player }
  end

  describe 'validations' do
    it { should validate_presence_of :text }

    it 'should like real words' do
      word = Word.create text: 'word'
      expect(word.errors).to be_empty
    end

    it 'should require a word to actually be a word' do
      # TODO only fail on the word 'fail' for now
      word = Word.create text: 'fail'
      expect(word.errors.first).to eq [:text, "must be a valid word according to the dictionary"]
    end
  end

  it 'should calculate points' do
    a = Letter.create text: 'a', points: 1
    b = Letter.create text: 'b', points: 2
    c = Letter.create text: 'c', points: 3
    word = Word.create text: 'abc'
    expect(word.points).to eq 6
  end
end
