FactoryBot.define do
  factory :event_participant, class: EventParticipant do
    association :event, factory: :event
    association :participant, factory: :user
    status { ::PARTICIPANT_STATUS_WAITING}
  end
end