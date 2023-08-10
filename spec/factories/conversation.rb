FactoryBot.define do
  factory :conversation, class: Conversation do
    conversation_type { ::CONVERSATION_ONE_ON_ONE_TYPE }
    association :created_by, factory: :user
    source_id { SecureRandom.uuid }
  end
end