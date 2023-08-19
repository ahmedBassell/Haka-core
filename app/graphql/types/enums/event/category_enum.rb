# typed: ignore
module Types
  module Enums
    module Event
      class CategoryEnum < Types::BaseEnum
        graphql_name "EventCategoryEnum"

        value ::EVENT_CATEGORY_KAHA_GAME.to_s.upcase, value: ::EVENT_CATEGORY_KAHA_GAME.to_s
        value ::EVENT_CATEGORY_KAHA_DRILL.to_s.upcase, value: ::EVENT_CATEGORY_KAHA_DRILL.to_s
        value ::EVENT_CATEGORY_MEETUP.to_s.upcase, value: ::EVENT_CATEGORY_MEETUP.to_s
        value ::EVENT_CATEGORY_REGIONAL_ADV.to_s.upcase, value: ::EVENT_CATEGORY_REGIONAL_ADV.to_s
        value ::EVENT_CATEGORY_INTERNATIONAL_ADV.to_s.upcase, value: ::EVENT_CATEGORY_INTERNATIONAL_ADV.to_s
      end
    end
  end
end
