# typed: ignore
module Resolvers
  class ConversationsResolver < BaseResolver
    argument :categories, [::Types::Enums::Conversation::CategoryEnum], "conversation types", required: false

    type ::Types::ConversationType.connection_type, null: false

    def resolve(types: [])
      current_user = context[:current_user]
      conversations = ::Conversation.includes(:participants).where("participants.user_id": current_user.id)

      conversations = conversations.where(conversation_type: types) unless types.empty?

      conversations
    end
  end
end
