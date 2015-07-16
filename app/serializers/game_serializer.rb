class GameSerializer < ActiveModel::Serializer
  attributes :id, :friendly_name
  has_many :players
end
