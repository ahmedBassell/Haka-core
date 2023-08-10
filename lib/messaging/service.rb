# typed: true
# frozen_string_literal: true

module Messaging
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    sig { params( payload: ::Messaging::Models::MessagePayload ).returns(T.nilable(::Message)) }
    def self.create_message!(payload:)
      creator = ::Messaging::Resolver.resolve_message_creator(payload.message_origin_type).new(payload)
      creator.create!
    end
  end
end
