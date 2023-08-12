# frozen_string_literal: true

module Types
  module Unions
    class MessageBodyUnion < Types::BaseUnion
      TypeNotSupportedError = Class.new(StandardError)
  
      possible_types ::Types::Message::TextBodyType, ::Types::Message::WaitingBodyType, ::Types::Message::ConfirmedBodyType

      def self.resolve_type(object, context)
        case object.message_type
        when ::MESSAGE_TEXT_TYPE.to_s
          ::Types::Message::TextBodyType
        when ::MESSAGE_WAITING_TYPE.to_s
          ::Types::Message::WaitingBodyType
        else
          raise TypeNotSupportedError
        end
      end

    end
  end
end
