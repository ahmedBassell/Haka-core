FactoryBot.define do
  factory :event, class: Event do
    category { ::EVENT_CATEGORY_MEETUP }
    display_name { "New event" }
    description { "New event description" }
    date { Date.new }
    from { DateTime.now }
    to { DateTime.now }
    canceled_at { nil }
    association :created_by, factory: :user
    
    trait :kaha_game do
      category { ::EVENT_CATEGORY_KAHA_GAME }
    end

    trait :canceled do
      canceled_at { ::DateTime.now }
      # canceled_by { self.created_by }
    end
  end
end