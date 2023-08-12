# typed: ignore
module Types
  class MessageType < Types::BaseObject
    graphql_name "MessageType"

    field :id, ::Integer, null: false
    field :message_type, ::Types::Enums::Message::CategoryEnum, null: false
    field :message_subtype, ::Types::Enums::Message::SubCategoryEnum, null: false
    field :message_origin_type, ::Types::Enums::Message::OriginCategoryEnum, null: false
    field :replied_to, ::GraphQL::Types::Boolean, null: false
    field :forwarded, ::GraphQL::Types::Boolean, null: false
    field :user, ::Types::UserType, null: false
    field :body, ::Types::Unions::MessageBodyUnion, null: false
    
    field :created_at, ::Integer, null: false

    def body
      object
    end
  end
end
