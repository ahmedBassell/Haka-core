FactoryBot.define do
  factory :message, class: Message do
    message_type { ::MESSAGE_TEXT_TYPE }
    message_subtype { ::MESSAGE_NO_SUBTYPE }
    source_id { "<SOURCE>" }
    association :user, factory: :user
  end
end