# typed: ignore
module Mutations
  module Event
    class Participate < ::Mutations::BaseMutation
      graphql_name "EventParticipate"

      argument :event_id, ::Integer, required: true
      field :event, ::Types::EventType, null: false

      def resolve(event_id:)
        current_user = context[:current_user]
        event = ::Events::Service.participate!(event_id: event_id, participant: current_user)
        
        { event: event.reload }
      end
    end
  end
end
