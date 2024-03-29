# typed: ignore
module Types
  module DirectUpload
    class Response < GraphQL::Schema::Object
      description "Represents direct upload credentials"

      field :url, ::String, "Upload URL", null: false
      field :headers, ::String, "HTTP request headers (JSON-encoded)", null: false
      field :blob_id, ::GraphQL::Types::ID, "Created blob record ID", null: false
      field :signed_blob_id, ::GraphQL::Types::ID, "Created blob record signed ID", null: false
    end
  end
end
