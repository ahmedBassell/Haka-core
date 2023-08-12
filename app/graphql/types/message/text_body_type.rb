# typed: ignore
module Types
  module Message
    class TextBodyType < Types::BaseObject
      graphql_name "MessageTextBodyType"

      field :text, ::String, null: false

      def text
        "hello"
      end
    end
  end
end
