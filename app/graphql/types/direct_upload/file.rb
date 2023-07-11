# typed: ignore
module Types
  module DirectUpload
    class File < GraphQL::Schema::InputObject
      description "File information required to prepare a direct upload"

      argument :filename, ::String, "Original file name", required: true
      argument :byte_size, ::Integer, "File size (bytes)", required: true
      argument :checksum, ::String, "MD5 file checksum as base64", required: true
      argument :content_type, ::String, "File content type", required: true
    end
  end
end
