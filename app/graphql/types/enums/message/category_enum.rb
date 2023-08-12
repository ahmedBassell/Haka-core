# typed: ignore
module Types
  module Enums
    module Message
      class CategoryEnum < Types::BaseEnum
        graphql_name "MessageCategoryEnum"

        value "TEXT", value: ::MESSAGE_TEXT_TYPE.to_s
        value "WAITING", value: ::MESSAGE_WAITING_TYPE.to_s
      end
    end
  end
end
