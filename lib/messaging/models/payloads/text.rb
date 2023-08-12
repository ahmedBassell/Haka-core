# typed: ignore
# frozen_string_literal: true

module Messaging
  module Models
    module Payloads
      class Text < T::Struct
        prop :sender, ::User
        prop :receiver, T.nilable(::User)
        prop :conversation, ::Conversation
        prop :text, ::String
        prop :message_type, ::Messaging::Models::Enums::MessageType, default: ::Messaging::Models::Enums::MessageType::Text
        prop :message_subtype, ::Messaging::Models::Enums::MessageSubtype, default: ::Messaging::Models::Enums::MessageSubtype::No_Subtype
        prop :message_origin_type, ::Messaging::Models::Enums::MessageOriginType, default: ::Messaging::Models::Enums::MessageOriginType::User
        prop :idempotency_key, T.nilable(::String)
        prop :reply_to_message_id, T.nilable(::String)
        
        def to_hash
          {}
        end
      end
    end
  end
end
