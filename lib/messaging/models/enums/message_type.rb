# typed: ignore
# frozen_string_literal: true

module Messaging
  module Models
    module Enums
      class MessageType < T::Enum
        enums do
          Text        = new(::MESSAGE_TEXT_TYPE)
          Image       = new(::MESSAGE_IMAGE_TYPE)
          # Video       = new
          # Audio       = new
          # Document    = new
        end
      end
    end
  end
end
