# typed: ignore
module Types
  module Enums
    module EventParticipant
      class StatusEnum < Types::BaseEnum
        graphql_name "EventParticipantStatusEnum"

        value "WAITING", value: ::PARTICIPANT_STATUS_WAITING.to_s
        value "CONFIRMED", value: ::PARTICIPANT_STATUS_CONFIRMED.to_s
      end
    end
  end
end
