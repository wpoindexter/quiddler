class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy

  validates :friendly_name, uniqueness: true
end
