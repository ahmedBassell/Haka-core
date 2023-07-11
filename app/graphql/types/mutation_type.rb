module Types
  class MutationType < Types::BaseObject
    field :direct_upload_create, mutation: Mutations::DirectUpload::BlobCreate
    field :user_update, mutation: Mutations::User::Update
  end
end
