# typed: true
# frozen_string_literal: true

module Messaging
  module Creators
    class SystemMessageCreator < Base
      extend ::T::Sig
      extend ::T::Helpers

      sig { override.returns(T.nilable(::Message)) }
      def create!
        validate!

        message = create_system_message!(payload: payload)

        ::Notifications::Service.notify! if message.present?
      
        message
      rescue ::ActiveRecord::RecordNotUnique => _
        nil
      end

      private

      sig do
        params(
          payload: T.any(::Messaging::Models::Payloads::Waiting, ::Messaging::Models::Payloads::Confirmed)
        ).returns(T.nilable(::Message))
      end
      def create_system_message!(payload:)
        idempotency_key = payload.idempotency_key
        event = payload.event
        user = payload.user
        
        conversation = find_or_create_one_on_one_conversation(user, event.created_by)
        participants = find_or_create_participants(conversation, [user, event.created_by])

        bot_user = nil
        # TODO: Create a reserved user for bot actions, or create new table for bot users and support polymorphism
        # there should be bot user table and a default bot user
        # Message.user need to accept any of (user or bot_user)
        message_type = 
          case payload
          when ::Messaging::Models::Payloads::Waiting
            ::MESSAGE_WAITING_TYPE
          when ::Messaging::Models::Payloads::Confirmed
            ::MESSAGE_CONFIRMED_TYPE
          end

        ::Message.create!(
          source_id: idempotency_key,
          message_type: message_type,
          message_subtype: ::MESSAGE_NO_SUBTYPE,
          message_origin_type: ::MESSAGE_ORIGIN_SYSTEM,
          payload: payload.to_hash,
          user: event.created_by, # ??
          conversation: conversation
        )
      rescue ::ActiveRecord::RecordNotUnique => _
        nil
      end
      
      sig { params( user_one: ::User, user_two: ::User ).returns(::Conversation) }
      def find_or_create_one_on_one_conversation(user_one, user_two)
        conversation = ::Conversations::Service.find_one_on_one(first_user_id: user_one.id, second_user_id: user_two.id)
        if conversation.blank?
          conversation = ::Conversations::Service.create_one_on_one!(first_user_id: user_one.id, second_user_id: user_two.id)
        end
  
        conversation
      end
  
      sig { params( conversation: ::Conversation, users: ::T::Array[::User] ).returns(::T::Array[::ConversationParticipant]) }
      def find_or_create_participants(conversation, users)
        participants = []
        users.each do |user|
          participant = conversation.participants.find_by(user: user)
          participants << (participant.present? ? participant : conversation.participants.create!(user: user))
        end
  
        participants
      end

    end
  end
end