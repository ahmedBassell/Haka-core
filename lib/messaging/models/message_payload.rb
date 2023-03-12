# typed: ignore
# frozen_string_literal: true

module Messaging
  module Models
    MessagePayload =
      T.type_alias do
        T.any(
          ::Messaging::Models::Payloads::Text,
          ::Messaging::Models::Payloads::Image,
          # ::Messaging::Models::Payloads::ImageBlob,
          # ::Messaging::Models::Payloads::Audio,
          # ::Messaging::Models::Payloads::AudioBlob,
          # ::Messaging::Models::Payloads::Video,
          # ::Messaging::Models::Payloads::VideoBlob,
          # ::Messaging::Models::Payloads::Document,
          # ::Messaging::Models::Payloads::DocumentBlob,
          # ::Messaging::Models::Payloads::JoinGroup
        )
      end
  end
end
