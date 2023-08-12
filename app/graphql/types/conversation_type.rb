# typed: ignore
module Types
  class ConversationType < Types::BaseObject
    graphql_name "ConversationType"

    field :id, ::Integer, null: false
  end
end
