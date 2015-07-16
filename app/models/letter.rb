class Letter < ActiveRecord::Base
  validates :text, uniqueness: true

  def self.points(text)
    letter = Letter.find_by text: text
    letter.nil? ? 0 : letter.points
  end
end
