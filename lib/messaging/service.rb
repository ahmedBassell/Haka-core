# typed: true
# frozen_string_literal: true

module Messaging
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    sig do
      params(
        sender: ::User,
        receiver: ::User,
        text_body: ::String,
        idempotency_key: ::String
      ).returns(::T.nilable(::Message))
    end
    def self.create_direct_message!(sender:, receiver:, text_body:, idempotency_key:)
      ::ActiveRecord::Base.transaction do
        message_type = ::Messaging::Models::Enums::MessageType::Text
        conversation = ::Conversations::Service.find_or_create_one_on_one_conversation(sender, receiver)
        conversation_participants = ::Conversations::Service.find_or_create_participants(conversation: conversation, users: [sender, receiver])
        payload_klass = ::Messaging::Resolver.resolve_message_payload(message_type)
        payload = payload_klass.new(
          conversation: conversation,
          text: text_body,
          message_type: ::Messaging::Models::Enums::MessageType::Text,
          message_subtype: ::Messaging::Models::Enums::MessageSubtype::No_Subtype,
          idempotency_key: idempotency_key,
          reply_to_message_id: nil,
          sender: sender,
          receiver: receiver
        )

        create_message!(payload: payload)
      end
    end

    sig do
      params(
        sender: ::User,
        conversation: ::Conversation,
        text_body: ::String,
        idempotency_key: ::String
      ).returns(::T.nilable(::Message))
    end
    def self.create_conversation_message!(sender:, conversation:, text_body:, idempotency_key:)
      ::ActiveRecord::Base.transaction do
        message_type = ::Messaging::Models::Enums::MessageType::Text
        
        payload_klass = ::Messaging::Resolver.resolve_message_payload(message_type)
        payload = payload_klass.new(
          conversation: conversation,
          text: text_body,
          message_type: ::Messaging::Models::Enums::MessageType::Text,
          message_subtype: ::Messaging::Models::Enums::MessageSubtype::No_Subtype,
          idempotency_key: idempotency_key,
          reply_to_message_id: nil,
          sender: sender
        )

        create_message!(payload: payload)
      end
    end

    sig do
      params(
        sender: ::User,
        event: ::Event,
        text_body: ::String,
        idempotency_key: ::String
      ).returns(::T.nilable(::Message))
    end
    def self.create_group_message!(sender:, event:, text_body:, idempotency_key:)
      ::ActiveRecord::Base.transaction do
        message_type = ::Messaging::Models::Enums::MessageType::Text
        conversation = ::Conversations::Service.find_or_create_group_conversation(sender, event)
        conversation_participants = ::Conversations::Service.find_or_create_participants(conversation: conversation, users: [sender, event.created_by])
        payload_klass = ::Messaging::Resolver.resolve_message_payload(message_type)
        payload = payload_klass.new(
          conversation: conversation,
          text: text_body,
          message_type: ::Messaging::Models::Enums::MessageType::Text,
          message_subtype: ::Messaging::Models::Enums::MessageSubtype::No_Subtype,
          idempotency_key: idempotency_key,
          reply_to_message_id: nil,
          sender: sender,
          receiver: receiver
        )

        create_message!(payload: payload)
      end
    end

    sig do
      params(
        user: ::User,
        event: ::Event,
        message_type: ::Messaging::Models::Enums::MessageType,
        idempotency_key: ::String
      ).returns(::T.nilable(::Message))
    end
    def self.create_system_message!(user:, event:, message_type:, idempotency_key:)
      ::ActiveRecord::Base.transaction do
        conversation = ::Conversations::Service.find_or_create_one_on_one_conversation(user, event.created_by)
        conversation_participants = ::Conversations::Service.find_or_create_participants(conversation: conversation, users: [user, event.created_by])
        payload_klass = ::Messaging::Resolver.resolve_message_payload(message_type)
        payload = payload_klass.new(
          conversation: conversation,
          user: user,
          event: event,
          idempotency_key: idempotency_key,
        )

        create_message!(payload: payload)
      end
    end

    private

    sig { params( payload: ::Messaging::Models::MessagePayload ).returns(T.nilable(::Message)) }
    def self.create_message!(payload:)
      creator = ::Messaging::Resolver.resolve_message_creator(payload.message_origin_type).new(payload)
      creator.create!
    end
  end
end
