# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

owner = ::User.create!(phone:"199", password: "password", display_name: "Me", email: "me@haka.io", role: ::ROLE_OWNER)
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
# date = DateTime.now.utc.to_date.next_occurring(:sunday)

def seed_events(owner, member)
  events_arr = [
    {
      isFullyBooked: false,
      id: '1',
      title: 'Rock scrambling @ wadi degla protectorate',
      description:
          'Details: a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here',
      # country: 'Egypt',
      # city: 'Cairo',
      # joinedCount: 21,
      category: ::EVENT_CATEGORY_MEETUP,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    },
    {
      isFullyBooked: true,
      id: '2',
      title: 'Nabaq adventure',
      description:
          'Details: a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here',
      # country: 'Egypt',
      # city: 'Cairo',
      # joinedCount: 2,
      category: ::EVENT_CATEGORY_MEETUP,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    },
    {
      isFullyBooked: false,
      id: '3',
      title: 'Siwa adventure',
      description:
          'Details: a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here',
      # country: 'Egypt',
      # city: 'Cairo',
      # joinedCount: 14,
      category: ::EVENT_CATEGORY_MEETUP,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    },
    {
      isFullyBooked: false,
      id: '4',
      title: 'Paddel tournment',
      description: 'Details: ...',
      # country: 'Egypt',
      # city: 'Cairo',
      # joinedCount: 10,
      category: ::EVENT_CATEGORY_MEETUP,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    },
    {
      isFullyBooked: false,
      id: '5',
      title: 'Black & White desert camping',
      description: 'Details: ...',
      # country: 'Egypt',
      # city: 'Cairo',
      category: ::EVENT_CATEGORY_MEETUP,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    },
    {
      isFullyBooked: false,
      id: '5',
      title: 'Lebanon adv',
      description: 'Details: ...',
      # country: 'Lebanon',
      # city: 'Beirut',
      # joinedCount: 1,
      category: ::EVENT_CATEGORY_INTERNATIONAL_ADV,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    },
    {
      isFullyBooked: false,
      id: '6',
      title: 'Turkey adv',
      description:
          'Details: a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here a very long details here and another very long program here',
      # country: 'Turkey',
      # city: 'Istanbul',
      # joinedCount: 5,
      category: ::EVENT_CATEGORY_INTERNATIONAL_ADV,
      scheduled_at: ::DateTime.now(),
      created_at: ::DateTime.now()
    }
  ]

  events_arr.each do |event_hash|
    date = event_hash[:scheduled_at].utc.to_date.next_occurring(:sunday)
    event = ::Event.create!(
      category: event_hash[:category],
      display_name: event_hash[:title],
      description: event_hash[:description],
      date: event_hash[:scheduled_at],
      from: date.to_datetime.change(hour: 20),
      to: date.to_datetime.change(hour: 22),
      discarded_at: nil,
      expires_at: nil,
      longitude: 30.022589,
      latitude: 31.465067,
      images: [],
      created_by: owner
    )
    event.images.attach(io: File.open("#{Rails.root}/db/seed_attachments/test.jpg"), filename: 'test.jpg', content_type: 'image/jpg')

    participant = ::EventParticipant.create!(
      event: event,
      participant: member,
      status: ::PARTICIPANT_STATUS_WAITING
    )
  end
end

seed_events(owner, member)