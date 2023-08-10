module Conversations
  module Models
    module Enums
      class ConversationType < T::Enum
        enums do
          OneOnOne = new(::CONVERSATION_ONE_ON_ONE_TYPE)
          EventGroup = new(::CONVERSATION_EVENT_GROUP_TYPE)
          Broadcast = new(::CONVERSATION_BROADCAST_TYPE)
        end
      end
    end
  end
end