FactoryBot.define do
  factory :conversation_participant, class: ConversationParticipant do
    conversation
    user
    # association :user, factory: :user
  end
end