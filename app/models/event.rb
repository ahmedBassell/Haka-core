class Event < ApplicationRecord
  enum category: ::EVENT_CATEGORYS_MAP
  
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  has_many :event_participants, dependent: :destroy, foreign_key: "event_id"
end
