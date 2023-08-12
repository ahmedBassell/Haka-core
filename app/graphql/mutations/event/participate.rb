# typed: ignore
module Mutations
  module Event
    class Participate < ::Mutations::BaseMutation
      graphql_name "EventParticipate"

      argument :event_id, ::Integer, required: true
      argument :idempotency_key, ::String, required: true

      field :event, ::Types::EventType, null: false

      def resolve(event_id:, idempotency_key:)
        current_user = context[:current_user]
        event = ::Events::Service.participate!(event_id: event_id, participant: current_user, idempotency_key: idempotency_key)
        
        { event: event.reload }
      end
    end
  end
end
