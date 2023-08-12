# typed: ignore
module Types
  module Enums
    module Message
      class OriginCategoryEnum < Types::BaseEnum
        graphql_name "OriginCategoryEnum"

        value "USER", value: ::MESSAGE_ORIGIN_USER.to_s
        value "SYSTEM", value: ::MESSAGE_ORIGIN_SYSTEM.to_s
      end
    end
  end
end
