# typed: ignore
module Resolvers
  class ConversationResolver < BaseResolver
    argument :conversation_id, ::Integer, "conversation id", required: true

    type ::Types::ConversationType.connection_type, null: false

    def resolve(conversation_id:)
      current_user = context[:current_user]
      # make sure that current user is participant to this conversation, else throw an error
      conversation = ::Conversation.find(conversation_id)
      ::Conversations::Service.validate_conversation_participant!(current_user, conversation)

      conversation
    rescue ::Conversations::Errors::UserNotConversationParticipantError => e
      raise GraphQL::ExecutionError.new("user is not participant in conversation!", extensions: { "code" => "USER_NOT_CONVERSATION_PARTICIPANT" })
    rescue ::ActiveRecord::RecordNotFound => e
      raise GraphQL::ExecutionError.new("conversation not found!", extensions: { "code" => "CONVERSATION_NOT_FOUND" })
    end
  end
end
