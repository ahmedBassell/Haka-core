# typed: ignore
module Types
  module Enums
    module Message
      class SubCategoryEnum < Types::BaseEnum
        graphql_name "MessageSubCategoryEnum"

        value "NO_SUBTYPE", value: ::MESSAGE_NO_SUBTYPE.to_s
        value "REPLIED_TO", value: ::MESSAGE_REPLIED_TO_SUBTYPE.to_s
        value "FORWARDED", value: ::MESSAGE_FORWARDED_SUBTYPE.to_s
      end
    end
  end
end
