class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  enum message_type: ::MESSAGE_TYPES_MAP
  enum message_subtype: ::MESSAGE_SUBTYPES_MAP
  enum message_origin_type: ::MESSAGE_ORIGIN_MAP
end
