# typed: true
# frozen_string_literal: true

module Messaging
  module Creators
    class UserMessageCreator < Base
      extend ::T::Sig
      extend ::T::Helpers

      sig { override.returns(T.nilable(::Message)) }
      def create!
        validate!

        message = T.let(nil, T.nilable(::Message))

        message = ::Message.find_by(conversation: payload.conversation, source_id: payload.idempotency_key)

        return message if message.present?

        case ::Conversations::Models::Enums::ConversationType.from_serialized(payload.conversation.conversation_type.to_sym)
        when ::Conversations::Models::Enums::ConversationType::OneOnOne
          message = create_one_on_one_message!
        when ::Conversations::Models::Enums::ConversationType::EventGroup
          message = create_group_message!
        end

        ::Notifications::Service.notify! if message.present?
        
        message
      rescue ::ActiveRecord::RecordNotUnique => _
        nil
      end

      private

      sig { returns(T.nilable(::Message)) }
      def create_one_on_one_message!
        message = T.let(nil, T.nilable(::Message))
        sender = payload.sender
        receiver = payload.receiver
        conversation = payload.conversation

        message = conversation.messages.create!(
          source_id: payload.idempotency_key,
          message_type: payload.message_type.serialize,
          message_subtype: payload.message_subtype.serialize,
          source_reply_to_message_id: payload.reply_to_message_id,
          source_forward_from_user_id: nil,
          source_forward_from_conversation_id: nil,
          source_forward_from_message_id: nil,
          replied_to: payload.reply_to_message_id.present?,
          forwarded: false,
          payload: {text: payload.text},
          user: sender,
        )
      end

      sig { returns(T.nilable(::Message)) }
      def create_group_message!
        message = T.let(nil, T.nilable(::Message))
        sender = payload.sender
        conversation = payload.conversation

        message = conversation.messages.create!(
          source_id: payload.idempotency_key,
          message_type: payload.message_type.serialize,
          message_subtype: payload.message_subtype.serialize,
          source_reply_to_message_id: payload.reply_to_message_id,
          source_forward_from_user_id: nil,
          source_forward_from_conversation_id: nil,
          source_forward_from_message_id: nil,
          replied_to: payload.reply_to_message_id.present?,
          forwarded: false,
          payload: {text: payload.text},
          user: sender,
        )
      end
    end
  end
end