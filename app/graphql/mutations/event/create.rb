# typed: ignore
module Mutations
  module Event
    class Create < ::Mutations::BaseMutation
      graphql_name "EventCreate"

      argument :name, ::String, required: true
      argument :description, ::String, required: true
      argument :category, ::Types::Enums::Event::CategoryEnum, required: true
      argument :date, ::Integer, required: true
      argument :from, ::Integer, required: true
      argument :to, ::Integer, required: true

      field :event, ::Types::EventType, null: false

      def resolve(name:, description:, category:, date:, from:, to:)
        current_user = context[:current_user]
        category = ::Events::Models::Enums::CategoryType.from_serialized(category.to_sym)
        date = ::Time.at(date).to_date
        from = ::Time.at(from).utc.to_datetime
        to = ::Time.at(to).utc.to_datetime
        event = ::Events::Service.create!(name: name, description: description, category: category, date: date, from: from, to: to, created_by: current_user)
        
        { event: event.reload }
      end
    end
  end
end
