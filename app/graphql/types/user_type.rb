# typed: ignore
module Types
  class UserType < Types::BaseObject
    graphql_name "UserType"

    field :id, ::Integer, null: false
    field :uuid, ::String, null: false
    field :display_name, ::String, null: false
    field :email, ::String, null: false
    field :created_at, ::Integer, null: false
  end
end
