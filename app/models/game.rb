class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy
  validates :friendly_name, presence: true, uniqueness: true
end
