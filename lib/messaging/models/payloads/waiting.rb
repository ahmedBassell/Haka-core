# typed: ignore
# frozen_string_literal: true

module Messaging
  module Models
    module Payloads
      class Waiting < T::Struct
        prop :event, ::Event
        prop :user, ::User
        prop :conversation, ::Conversation
        prop :message_type, ::Messaging::Models::Enums::MessageType, default: ::Messaging::Models::Enums::MessageType::Waiting
        prop :message_subtype, ::Messaging::Models::Enums::MessageSubtype, default: ::Messaging::Models::Enums::MessageSubtype::No_Subtype
        prop :message_origin_type, ::Messaging::Models::Enums::MessageOriginType, default: ::Messaging::Models::Enums::MessageOriginType::System
        prop :idempotency_key, T.nilable(::String)

        def to_hash
          {
            user_id: user.id,
            event_id: event.id
          }
        end
      end
    end
  end
end
