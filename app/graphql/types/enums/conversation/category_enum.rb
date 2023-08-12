# typed: ignore
module Types
  module Enums
    module Conversation
      class CategoryEnum < Types::BaseEnum
        graphql_name "ConversationCategoryEnum"

        value "ONE_ON_ONE", value: ::CONVERSATION_ONE_ON_ONE_TYPE.to_s
        value "GROUP", value: ::CONVERSATION_EVENT_GROUP_TYPE.to_s
      end
    end
  end
end
