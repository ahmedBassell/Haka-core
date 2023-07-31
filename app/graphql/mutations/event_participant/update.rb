# typed: ignore
module Mutations
  module EventParticipant
    class Update < ::Mutations::BaseMutation
      graphql_name "EventParticipantUpdate"

      argument :id, ::Integer, required: true
      argument :status, ::Types::Enums::EventParticipant::StatusEnum, required: true

      field :event_participant, ::Types::EventParticipantType, null: false

      def resolve(id:, status:)
        current_user = context[:current_user]
        event_participant = ::EventParticipant.find(id)
        status = ::ParticipantStatusEnum.from_serialized(status.to_sym)
        event_participant = ::EventParticipants::Service.update_status!(event_participant: event_participant, status: status, update_by: current_user)
        
        { event_participant: event_participant.reload }
      end
    end
  end
end
