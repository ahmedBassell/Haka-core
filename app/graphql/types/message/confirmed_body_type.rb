# typed: ignore
module Types
  module Message
    class ConfirmedBodyType < Types::BaseObject
      graphql_name "MessageConfirmedBodyType"

      field :event, ::Types::EventType, null: false
    end
  end
end
