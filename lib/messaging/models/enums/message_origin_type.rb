# typed: ignore
# frozen_string_literal: true

module Messaging
  module Models
    module Enums
      class MessageOriginType < T::Enum
        enums do
          User        = new(::MESSAGE_ORIGIN_USER)
          System      = new(::MESSAGE_ORIGIN_SYSTEM)
        end
      end
    end
  end
end
