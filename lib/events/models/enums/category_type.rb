module Events
  module Models
    module Enums
      class CategoryType < T::Enum
        enums do
          KahaGame = new(EVENT_CATEGORY_KAHA_GAME)
          KahaDrill = new(EVENT_CATEGORY_KAHA_DRILL)
          Meetup = new(EVENT_CATEGORY_MEETUP)
          RegionalAdv = new(EVENT_CATEGORY_REGIONAL_ADV)
          InternationalAdv = new(EVENT_CATEGORY_INTERNATIONAL_ADV)
        end
      end
    end
  end
end