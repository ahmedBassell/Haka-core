FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    sequence(:phone) { |n| "+201#{n}00000000" }
    sequence(:display_name) { |n| "User Name #{n}" }
    password { "password" }
    role { ::ROLE_MEMBER }
    trait :member do
      role { ::ROLE_MEMBER }
    end

    trait :owner do
      role { ::ROLE_OWNER }
    end
  end
end