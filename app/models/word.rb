class Word < ActiveRecord::Base

  belongs_to :player

  validates :text, presence: true
  validate :text_must_be_a_word, on: :create

  def points
    value = 0
    text.split('').each { |l| value += Letter.points(l) }
    value
  end

  def valid_word?
    # TODO
    !text.eql? 'fail'
  end

  private

  def text_must_be_a_word
    errors.add :text, 'must be a valid word according to the dictionary' unless valid_word?
  end
end
