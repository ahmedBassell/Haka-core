# typed: ignore
module Types
  module Enums
    module Event
      class CategoryEnum < Types::BaseEnum
        graphql_name "EventCategoryEnum"

        value "KAHA_GAME", value: ::EVENT_CATEGORY_KAHA_GAME.to_s
        value "KAHA_DRILL", value: ::EVENT_CATEGORY_KAHA_DRILL.to_s
        value "MEETUP", value: ::EVENT_CATEGORY_MEETUP.to_s
        value "REGIONAL_ADV", value: ::EVENT_CATEGORY_REGIONAL_ADV.to_s
        value "INTERNATIONAL_ADV", value: ::EVENT_CATEGORY_INTERNATIONAL_ADV.to_s
      end
    end
  end
end
