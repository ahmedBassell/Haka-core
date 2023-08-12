# typed: ignore
module Mutations
  module Conversation
    module Direct
      class Create < ::Mutations::BaseMutation
        graphql_name "ConversationDirectCreate"

        argument :receiver_id, ::Integer, required: true

        type ::Types::ConversationType, null: false


        def resolve(receiver_id:)
          current_user = context[:current_user]
          receiver = ::User.find(receiver_id)
          conversation = ::Conversations::Service.find_or_create_one_on_one_conversation(current_user, receiver)
          conversation
        rescue ::ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new("receiver not found!", extensions: { "code" => "USER_NOT_FOUND" })
        end
      end
    end
  end
end
