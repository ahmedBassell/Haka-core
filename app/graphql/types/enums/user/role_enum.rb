# typed: ignore
module Types
  module Enums
    module User
      class RoleEnum < Types::BaseEnum
        graphql_name "UserRoleEnum"

        value "MEMBER", value: ::ROLE_MEMBER.to_s
        value "OWNER", value: ::ROLE_OWNER.to_s
      end
    end
  end
end
