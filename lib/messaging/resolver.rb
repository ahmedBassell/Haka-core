# typed: true
# frozen_string_literal: true

module Messaging
  class Resolver
    extend ::T::Sig
    extend ::T::Helpers

    MESSAGE_CREATOR_MAP = T.let({
      ::Messaging::Models::Enums::MessageOriginType::User => ::Messaging::Creators::UserMessageCreator,
      ::Messaging::Models::Enums::MessageOriginType::System => ::Messaging::Creators::SystemMessageCreator
    }, ::T::Hash[::Messaging::Models::Enums::MessageOriginType, T.class_of(::Messaging::Creators::Base)])


    MESSAGE_TYPE_MAP = T.let({
      ::Messaging::Models::Enums::MessageType::Text => ::Messaging::Models::Payloads::Text,
      ::Messaging::Models::Enums::MessageType::Waiting => ::Messaging::Models::Payloads::Waiting,
      ::Messaging::Models::Enums::MessageType::Confirmed => ::Messaging::Models::Payloads::Confirmed
    }, ::T::Hash[::Messaging::Models::Enums::MessageType, T::Class[::Messaging::Models::MessagePayload]])

    sig { params( message_origin_type: ::Messaging::Models::Enums::MessageOriginType ).returns(T.class_of(::Messaging::Creators::Base)) }
    def self.resolve_message_creator(message_origin_type)
      return MESSAGE_CREATOR_MAP[message_origin_type] if MESSAGE_CREATOR_MAP[message_origin_type].present?
      raise ::NotImplementedError
    end

    sig { params( message_type: ::Messaging::Models::Enums::MessageType ).returns(T::Class[::Messaging::Models::MessagePayload]) }
    def self.resolve_message_payload(message_type)
      return MESSAGE_TYPE_MAP[message_type] if MESSAGE_TYPE_MAP[message_type].present?
      raise ::NotImplementedError
    end
  end
end