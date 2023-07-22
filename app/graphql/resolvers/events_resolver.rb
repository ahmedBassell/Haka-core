# typed: ignore
module Resolvers
  class EventsResolver < BaseResolver
    argument :category, ::Types::Enums::Event::CategoryEnum, "event category arg", required: false

    type ::Types::EventType.connection_type, null: false

    def resolve(category:nil)
      events = Event.all
      category_klass = ::Events::Models::Enums::CategoryType.from_serialized(category.to_sym)
      events = events.where(category: category_klass.serialize) if category.present?

      events
    end
  end
end
