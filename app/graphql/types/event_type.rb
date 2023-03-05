# typed: ignore
module Types
  class EventType < Types::BaseObject
    field :id, Integer, null: false
    field :uuid, String, null: false
    field :display_name, String, null: false
    field :description, String, null: false
    field :created_at, Int, null: false
    field :updated_at, Int, null: false
  end
end
