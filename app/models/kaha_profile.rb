class KahaProfile < ApplicationRecord
  belongs_to :player, class_name: "User", foreign_key: "player_id"

  enum rank: ::KAHA_PROFILE_RANKS_MAP
  enum position: ::KAHA_PROFILES_POSITIONS_MAP
  enum priority: ::KAHA_PROFILES_PRIORITY_MAP
  enum booking_preference: ::KAHA_PROFILES_BOOKING_MAP
end
