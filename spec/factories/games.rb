FactoryGirl.define do
  factory :game do
    sequence :friendly_name do |n|
      "Game #{n}"
    end

    trait :active do
      active true
    end

    trait :inactive do
      active false
    end

    factory :active_game, traits: [:active]
    factory :inactive_game, traits: [:inactive]
  end
end
