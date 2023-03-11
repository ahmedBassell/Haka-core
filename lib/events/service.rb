# typed: true
# frozen_string_literal: true

module Events
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    sig do
      params(
        name: ::String,
        description: ::String,
        category: ::Events::Models::Enums::CategoryType,
        date: ::Date,
        from: ::DateTime,
        to: ::T.nilable(::DateTime),
        created_by: ::User
      ).returns(::Event)
    end
    def self.create!(name:, description:, category:, date:, from:, to:, created_by:)
      raise ::Users::Errors::Unauthorized unless created_by.owner?
      raise ::Events::Errors::InvalidDate unless date > Date.today
      raise ::Events::Errors::InvalidTime unless to > from

      ::Event.create!(
        category: category.serialize,
        display_name: name,
        description: description,
        date: date,
        from: from,
        to: to,
        discarded_at: nil,
        expires_at: nil,
        location_link: "",
        created_by: created_by
      )
    end

    def self.update! ; end

    sig do
      params(
        event_id: ::Integer,
        canceled_by: ::User
      ).returns(::Event)
    end
    def self.cancel!(event_id:, canceled_by:)
      raise ::Users::Errors::Unauthorized unless canceled_by.owner?

      event = ::Event.find(event_id)
      raise ::Events::Errors::AlreadyCanceled if event.canceled?

      event.update!(canceled_at: ::DateTime.now, canceled_by: canceled_by)
      event.reload
    end

    sig do
      params(
        event_id: ::Integer,
        uncanceled_by: ::User
      ).returns(::Event)
    end
    def self.uncancel!(event_id:, uncanceled_by:)
      raise ::Users::Errors::Unauthorized unless uncanceled_by.owner?

      event = ::Event.find(event_id)
      raise ::Events::Errors::AlreadyUnCanceled unless event.canceled?

      event.update!(canceled_at: nil, canceled_by: nil)
      event.reload
    end

    sig do
      params(
        event_id: ::Integer,
        destroyed_by: ::User
      ).returns(::Event)
    end
    def self.destroy!(event_id:, destroyed_by:)
      raise ::Users::Errors::Unauthorized unless destroyed_by.owner?

      event = ::Event.find(event_id)
      event.discard!
      event.reload
    end
  end
end
