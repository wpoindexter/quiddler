FactoryGirl.define do
  factory :player do
    sequence :name do |n|
      "Player #{n}"
    end
    scorekeeper false
    game
  end
end
