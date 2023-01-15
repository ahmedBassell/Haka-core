class Event < ApplicationRecord
  has_one :user

  enum category: ::EVENT_CATEGORYS_MAP
end
