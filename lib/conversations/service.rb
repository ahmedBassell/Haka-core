# typed: true
# frozen_string_literal: true

module Conversations
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    # One on One
    sig do
      params(
        first_user_id: ::Integer,
        second_user_id: ::Integer
      ).returns(::T.nilable(::Conversation))
    end
    def self.find_one_on_one(first_user_id:, second_user_id:)
      identifier = compute_one_on_one_identifier(first_user_id: first_user_id, second_user_id: second_user_id)
      ::Conversation.find_by(source_id: identifier)
    end

    sig do
      params(
        first_user_id: ::Integer,
        second_user_id: ::Integer
      ).returns(::Conversation)
    end
    def self.create_one_on_one!(first_user_id:, second_user_id:)
      creator = :: User.find_by(id: first_user_id) || ::User.find_by(id: second_user_id)
      source_id = compute_one_on_one_identifier(first_user_id: first_user_id, second_user_id: second_user_id)
      conversation_type = ::CONVERSATION_ONE_ON_ONE_TYPE.to_s

      ::Conversation.create!(created_by: creator, source_id: source_id, conversation_type: conversation_type)
    rescue ::ActiveRecord::RecordNotUnique => e
      conversation = ::Conversation.find_by(source_id: source_id)
      return conversation if conversation.present?

      raise e
    end

    # Event Group

    sig do
      params(
        user_id: ::Integer,
        event_id: ::Integer
      ).returns(::T.nilable(::Conversation))
    end
    def self.find_group_conversation(user_id:, event_id:)
      identifier = compute_group_identifier(user_id: user_id, event_id: event_id)
      ::Conversation.find_by(source_id: identifier)
    end

    sig do
      params(
        user_id: ::Integer,
        event_id: ::Integer
      ).returns(::Conversation)
    end
    def self.create_group_conversation!(user_id:, event_id:)
      user = :: User.find_by(id: user_id)
      event = ::Event.find_by(id: event_id)
      raise ::StandardError, "user or event does not exist" if user.blank? || event.blank?

      source_id = compute_group_identifier(user_id: user_id, event_id: event_id)
      conversation_type = ::CONVERSATION_EVENT_GROUP_TYPE.to_s

      ::Conversation.create!(created_by: user, source_id: source_id, conversation_type: conversation_type)
    rescue ::ActiveRecord::RecordNotUnique => e
      conversation = ::Conversation.find_by(source_id: source_id)
      return conversation if conversation.present?

      raise e
    end

    private

    sig { params( first_user_id: ::Integer, second_user_id: ::Integer ).returns(::String) }
    def self.compute_one_on_one_identifier(first_user_id:, second_user_id:)
      conversation_type = ::CONVERSATION_ONE_ON_ONE_TYPE.to_s
      first_user_id, second_user_id = [first_user_id, second_user_id].sort
      Digest::SHA1.hexdigest("#{conversation_type}:#{first_user_id}-#{second_user_id}")
    end

    sig { params( user_id: ::Integer, event_id: ::Integer ).returns(::String) }
    def self.compute_group_identifier(user_id:, event_id:)
      conversation_type = ::CONVERSATION_EVENT_GROUP_TYPE.to_s
      Digest::SHA1.hexdigest("#{conversation_type}:#{event_id}-#{user_id}")
    end

    
  end
end