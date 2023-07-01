# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

owner = ::User.create!(phone:"200", password: "password", display_name: "Zomor", email: "zomor@haka.io", role: ::ROLE_OWNER)
member = ::User.create!(phone:"201", password: "password", display_name: "Willy", email: "willy@haka.io", role: ::ROLE_MEMBER)
member_kaha_profile = ::KahaProfile.create!(
  player: member,
  rank: ::KAHA_PROFILE_RANK_PRO,
  position: ::KAHA_PROFILE_POSITION_ATTACKER,
  priority: ::KAHA_PROFILE_PRIORITY_HIGH,
  booking_preference: ::KAHA_PROFILE_BOOKING_MANUAL,
  appearances: 100,
  goals: 28
)
date = DateTime.now.utc.to_date.next_occurring(:sunday)
event = ::Event.create!(
  category: ::EVENT_CATEGORY_KAHA_GAME,
  display_name: "kAHA SUN 8-10 PM",
  description: "🤾",
  date: date,
  from: date.to_datetime.change(hour: 20),
  to: date.to_datetime.change(hour: 22),
  discarded_at: nil,
  expires_at: nil,
  longitude: 12.0,
  latitude: 12.0,
  created_by: owner
)
participant = ::EventParticipant.create!(
  event: event,
  participant: member,
  status: ::PARTICIPANT_STATUS_WAITING
)