module Types
  class MutationType < Types::BaseObject
    field :direct_upload_create, mutation: Mutations::DirectUpload::BlobCreate
    field :user_update, mutation: Mutations::User::Update
    field :event_participate, mutation: Mutations::Event::Participate
    field :event_participant_update, mutation: Mutations::EventParticipant::Update
    # Conversation
    field :conversation_direct_create, mutation: Mutations::Conversation::Direct::Create
    field :conversation_group_create, mutation: Mutations::Conversation::Group::Create
    # Message
    field :message_direct_create, mutation: Mutations::Message::Direct::Create
    field :message_group_create, mutation: Mutations::Message::Group::Create
  end
end
