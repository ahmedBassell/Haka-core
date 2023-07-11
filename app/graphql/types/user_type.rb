# typed: ignore
module Types
  class UserType < Types::BaseObject
    graphql_name "UserType"

    field :id, ::Integer, null: false
    field :uuid, ::String, null: false
    field :display_name, ::String, null: true
    field :email, ::String, null: false
    field :created_at, ::Integer, null: false
    field :avatar_url, ::String, null: true
  end
end
