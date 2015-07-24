class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy
  validates :friendly_name, presence: true, uniqueness: true

  def self.created_between(date)
    Game.where(['created_at >= ? AND created_at <= ?', date.beginning_of_day, date.end_of_day]).count
  end
end
