# typed: ignore
module Resolvers
  class EventParticipantsResolver < BaseResolver
    argument :event_id, ::Integer, "event id", required: false
    argument :statuses, [::Types::Enums::EventParticipant::StatusEnum], "event participants", required: false

    type ::Types::EventParticipantType.connection_type, null: false

    def resolve(lookahead:, event_id: nil, statuses: [])
      current_user = context[:current_user]

      participants = ::EventParticipant.includes(:participant)
      participants = participants.includes(:event) if lookahead.selects?(:event)
      participants = participants.where(event_id: event_id) if event_id.present?
      participants = participants.where(status: statuses) if statuses.present?

      participants
    end
  end
end
