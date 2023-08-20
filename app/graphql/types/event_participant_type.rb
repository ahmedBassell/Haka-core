# typed: ignore
module Types
  class EventParticipantType < Types::BaseObject
    graphql_name "EventParticipantType"

    field :id, ::Integer, null: false
    field :event, ::Types::EventType, null: false
    field :participant, ::Types::UserType, null: false
    field :status, ::Types::Enums::EventParticipant::StatusEnum, null: false
  end
end
