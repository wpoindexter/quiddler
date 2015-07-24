class Word < ActiveRecord::Base
  belongs_to :player
  validates :text, presence: true
  validate :text_must_be_a_word, on: :create

  def points
    value = 0
    text.split('').each { |l| value += letter(l).points }
    value
  end

  def valid_word?
    valid_word = DictionaryApi.word_exists? text
    WordVerification.create text: text, valid_word: valid_word
    valid_word
  end

  private

  def letter(letter)
    Letter.find_by text: letter
  end

  def text_must_be_a_word
    errors.add :text, 'must be a valid word according to the dictionary' unless valid_word?
  end
end
