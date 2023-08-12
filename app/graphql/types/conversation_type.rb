# typed: ignore
module Types
  class ConversationType < Types::BaseObject
    graphql_name "ConversationType"

    field :id, ::Integer, null: false
    field :conversation_type, ::Types::Enums::Conversation::CategoryEnum, null: false
    field :messages, ::Types::MessageType.connection_type, resolver: ::Resolvers::MessagesResolver, null: false
    field :created_by, ::Types::UserType, null: false
    field :last_message, ::Types::MessageType, null: true
    field :first_message_at, ::Integer, null: true
    field :last_message_at, ::Integer, null: true
    field :updated_at, ::Integer, null: true
    field :created_at, ::Integer, null: false

    def last_message
      object.messages.order(id: :desc).limit(1).last
    end
  end
end
