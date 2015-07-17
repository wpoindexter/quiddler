class GameSerializer < ActiveModel::Serializer
  attributes :id, :active, :friendly_name
  has_many :players
end
