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
        longitude: 0.0,
        latitude: 0.0,
        created_by: created_by
      )
    end

    sig do
      params(
        event_id: ::Integer,
        updated_by: ::User,
        display_name: ::String,
        description: ::String,
        category: ::Events::Models::Enums::CategoryType,
        date: ::Date,
        from: ::DateTime,
        to: ::T.nilable(::DateTime),
        longitude: ::Float,
        latitude: ::Float
      ).returns(::Event)
    end
    def self.update!(event_id:, updated_by:, display_name:, description:, category:, date:, from:, to:, longitude:, latitude:)
      raise ::Users::Errors::Unauthorized unless updated_by.owner?
      raise ::Events::Errors::InvalidDate unless date > Date.today
      raise ::Events::Errors::InvalidTime unless to > from

      event = ::Event.find(event_id)
      raise ::Events::Errors::AlreadyCanceled if event.canceled?

      event.update!(
        display_name: display_name,
        description: description,
        category: category.serialize,
        date: date,
        from: from,
        to: to,
        longitude: longitude,
        latitude: latitude
      )

      event.reload
    end

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

    sig do
      params(
        event_id: ::Integer,
        participant: ::User
      ).returns(::Event)
    end
    def self.participate!(event_id:, participant:)
      event = ::Event.find(event_id)
      ::EventParticipants::Service.create!(event: event, participant: participant)
      

      ::ActiveRecord::Base.transaction do
        # Conversation must have type and an identifier, for this case, type = one_on_one, identifier = user_id, creator_id
        conversation = ::Conversations::Service.find_one_on_one(first_user_id: participant.id, second_user_id: event.created_by_id)
        if conversation.blank?
          conversation = ::Conversations::Service.create_one_on_one!(first_user_id: participant.id, second_user_id: event.created_by_id)
        end
        # Create initial message if not exist with identifier (user id, event creator id, event id, participant status & idempotence_key(mutation_id))
        ::Messaging::Service.create_waiting_message!(conversation: conversation, event: event, user: participant, idempotency_key: idempotency_key)
        # Check if message exist
      end
      

      event.reload
    end
  end
end
