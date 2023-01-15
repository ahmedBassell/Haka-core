class EventParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: ::PARTICIPANT_STATUSES_MAP
end
