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

    def self.cancel! ; end

    def self.destroy! ; end
  end
end
