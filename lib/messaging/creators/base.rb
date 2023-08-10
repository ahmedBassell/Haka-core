# typed: true
# frozen_string_literal: true

module Messaging
  module Creators
    class Base
      extend ::T::Sig
      extend ::T::Helpers

      abstract!

      sig { returns(::Messaging::Models::MessagePayload) }
      attr_accessor :payload

      sig { params( payload: ::Messaging::Models::MessagePayload ).void }
      def initialize(payload)
        @payload = payload
      end

      sig { overridable.returns(T.nilable(::Message)) }
      def create!
        raise ::NotImplementedError
      end

      sig { void }
      def validate!
        case payload.conversation_type
        when ::Conversations::Models::Enums::ConversationType::OneOnOne
          T.must(payload.receiver) if payload.message_origin_type == ::Messaging::Models::Enums::MessageOriginType::User
        end
      end
    end
  end
end