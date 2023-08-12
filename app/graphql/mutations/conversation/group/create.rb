# typed: ignore
module Mutations
  module Conversation
    module Group
      class Create < ::Mutations::BaseMutation
        graphql_name "ConversationGroupCreate"

        argument :event_id, ::Integer, required: true
        type ::Types::ConversationType, null: false


        def resolve(event_id:)
          current_user = context[:current_user]
          event = ::Event.find(event_id)
          conversation = ::Conversations::Service.find_or_create_group_conversation(current_user, event)
          conversation
        rescue ::ActiveRecord::RecordNotFound => e
          raise GraphQL::ExecutionError.new("event not found!", extensions: { "code" => "EVENT_NOT_FOUND" })
        end
      end
    end
  end
end
