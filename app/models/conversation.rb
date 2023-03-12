class Conversation < ApplicationRecord
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  has_many :messages, dependent: :destroy
  has_many :participants, class_name: "ConversationParticipant", dependent: :destroy

  enum conversation_type: ::CONVERSATION_TYPES_MAP
end
