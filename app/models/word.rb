class Word < ActiveRecord::Base
  belongs_to :player

  validates :text, presence: true

  def points
    value = 0
    text.split('').each { |l| value += Letter.points(l) }
    value
  end
end
