# typed: ignore
module Mutations
  module Message
    module Group
      class Create < ::Mutations::BaseMutation
        graphql_name "MessageGroupCreate"

        argument :conversation_id, ::Integer, required: true
        argument :body, ::String, required: true
        argument :idempotency_key, ::String, required: true

        type ::Types::MessageType, null: false


        def resolve(conversation_id:, body:, idempotency_key:)
          current_user = context[:current_user]
          conversation = ::Conversation.find(conversation_id)

          ::Messaging::Service.create_conversation_message!(
            sender: current_user,
            conversation: conversation,
            text_body: body,
            idempotency_key: idempotency_key
          )
          
        rescue ::ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new("conversation not found!", extensions: { "code" => "CONVERSATION_NOT_FOUND" })
        end
      end
    end
  end
end
