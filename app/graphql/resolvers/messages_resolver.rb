# typed: ignore
module Resolvers
  class MessagesResolver < BaseResolver
    type ::Types::MessageType.connection_type, null: false

    def resolve
      conversation = object
      conversation.messages.order(id: :desc)
    end
  end
end
