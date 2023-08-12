# typed: ignore
module Types
  module Message
    class WaitingBodyType < Types::BaseObject
      graphql_name "MessageWaitingBodyType"

      field :event, ::Types::EventType, null: false
      def event
        parsed_payload = object.payload.with_indifferent_access
        event_id = parsed_payload[:event_id]
        ::Event.find(event_id)
      end
    end
  end
end
