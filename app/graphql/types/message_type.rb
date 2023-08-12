# typed: ignore
module Types
  class MessageType < Types::BaseObject
    graphql_name "MessageType"

    field :id, ::Integer, null: false
    field :created_at, ::Integer, null: false
  end
end
