# typed: ignore
module Resolvers
  class EventsResolver < BaseResolver
    type ::Types::EventType.connection_type, null: false

    def resolve
      Event.all
    end
  end
end
