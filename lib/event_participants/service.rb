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

    sig do
      params(
        event_participant: ::EventParticipant,
        status: ::ParticipantStatusEnum,
        update_by: ::User
      ).returns(::EventParticipant)
    end
    def self.update_status!(event_participant:, status:, update_by:)
      raise ::Users::Errors::Unauthorized unless update_by.owner?

      event_participant.update!(status: status.serialize)
      event_participant.reload
    end
  end
end
