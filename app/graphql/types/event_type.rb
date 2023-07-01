# typed: ignore
module Types
  class EventType < Types::BaseObject
    graphql_name "EventType"

    field :id, ::Integer, null: false
    field :uuid, ::String, null: false
    field :display_name, ::String, null: false
    field :description, ::String, null: false
    field :longitude, ::Float, null: true
    field :latitude, ::Float, null: true
    field :category, ::Types::Enums::Event::CategoryEnum, null: false
    field :created_by, ::Types::UserType, null: false
    field :created_at, ::Integer, null: false
    field :updated_at, ::Integer, null: false
  end
end
