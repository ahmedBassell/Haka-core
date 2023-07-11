# typed: ignore
module Mutations
  module User
    class Update < ::Mutations::BaseMutation
      graphql_name "UserUpdate"

      argument :signed_blob_id, ::String, required: true
      field :user, ::Types::UserType, null: false

      def resolve(signed_blob_id:)
        blob = ::ActiveStorage::Blob.find_signed(signed_blob_id)
        return unless blob.present?

        user = context[:current_user]
        user.avatar.attach(blob)
        
        { user: user.reload }
      end
    end
  end
end
