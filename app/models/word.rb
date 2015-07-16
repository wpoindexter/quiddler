class Word < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :player

  validates :text, presence: true
  validates_with WordValidator

  def points
    value = 0
    text.split('').each { |l| value += Letter.points(l) }
    value
  end
end
