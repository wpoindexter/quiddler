class WordSerializer < ActiveModel::Serializer
  attributes :id, :text, :points
  has_many :letters
end
