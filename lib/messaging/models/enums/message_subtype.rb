# typed: ignore
# frozen_string_literal: true

module Messaging
  module Models
    module Enums
      class MessageSubtype < T::Enum
        enums do
          No_Subtype  = new(::MESSAGE_NO_SUBTYPE)
          Replied_To  = new(::MESSAGE_REPLIED_TO_SUBTYPE)
          Forwarded   = new(::MESSAGE_FORWARDED_SUBTYPE)
        end
      end
    end
  end
end
