class Letter < ActiveRecord::Base
  validates :text, uniqueness: true

  def self.points(text)
    letter = Letter.where(text: text).first
    letter.nil? ? 0 : letter.points
  end
end
