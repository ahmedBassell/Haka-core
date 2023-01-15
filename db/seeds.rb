# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

owner = ::User.create!(phone:"200", password: "password", display_name: "Zomor", role: ::ROLE_OWNER)
member = ::User.create!(phone:"201", password: "password", display_name: "Heidi", role: ::ROLE_MEMBER)
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
  location_link: "http://maps.google.com/long&lat",
  user: owner
)