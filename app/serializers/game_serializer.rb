class GameSerializer < ActiveModel::Serializer
  attributes :friendly_name
  has_many :players
end
