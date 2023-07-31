module Types
  class MutationType < Types::BaseObject
    field :direct_upload_create, mutation: Mutations::DirectUpload::BlobCreate
    field :user_update, mutation: Mutations::User::Update
    field :event_participate, mutation: Mutations::Event::Participate
    field :event_participant_update, mutation: Mutations::EventParticipant::Update
  end
end
