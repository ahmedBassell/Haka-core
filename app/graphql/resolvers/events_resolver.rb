# typed: ignore
module Resolvers
  class EventsResolver < BaseResolver
    type [Types::EventType], null: false

    def resolve
      Event.all
    end
  end
end
