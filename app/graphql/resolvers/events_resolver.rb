# typed: ignore
module Resolvers
  class EventsResolver < BaseResolver
    argument :categories, [::Types::Enums::Event::CategoryEnum], "event categories", required: false

    type ::Types::EventType.connection_type, null: false

    def resolve(categories: [])
      events = Event.all
      categories = categories.map{|category| ::Events::Models::Enums::CategoryType.from_serialized(category.to_sym)&.serialize }
      events = events.where(category: categories) unless categories.empty?

      events
    end
  end
end
