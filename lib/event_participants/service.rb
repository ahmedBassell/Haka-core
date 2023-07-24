# typed: true
# frozen_string_literal: true

module EventParticipants
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    sig do
      params(
        event: ::Event,
        participant: ::User
      ).returns(::Event)
    end
    def self.create!(event:, participant:)
      ::EventParticipant.create!(event: event, participant: participant, status: ::PARTICIPANT_STATUS_WAITING)

      event.reload
    end
  end
end
