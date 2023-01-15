class EventParticipant < ApplicationRecord
  belongs_to :participant, class_name: "User", foreign_key: "participant_id"
  belongs_to :event

  enum status: ::PARTICIPANT_STATUSES_MAP
end
