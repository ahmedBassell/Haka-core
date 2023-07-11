# typed: ignore
module Mutations
  module DirectUpload
    class BlobCreate < ::Mutations::BaseMutation
      include ::ActiveStorage::Blob::Analyzable
      graphql_name "BlobCreate"

      argument :file, Types::DirectUpload::File, required: true
      field :direct_upload, Types::DirectUpload::Response, null: false

      def resolve(file:)
        blob = ::ActiveStorage::Blob.create_before_direct_upload!(**file.to_h)
        ##
        # we pass headers as JSON since they have no schema
        #
        {
          direct_upload: {
            url: blob.service_url_for_direct_upload,
            headers: blob.service_headers_for_direct_upload.to_json,
            blob_id: blob.id,
            signed_blob_id: blob.signed_id
          }
        }
      end
    end
  end
end
