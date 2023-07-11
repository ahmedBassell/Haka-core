# typed: ignore
module Resolvers
  class CurrentUserResolver < BaseResolver
    type ::Types::UserType, null: false

    def resolve
      context[:current_user]
    end
  end
end
