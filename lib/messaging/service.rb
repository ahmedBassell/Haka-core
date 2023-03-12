# typed: true
# frozen_string_literal: true

module Messaging
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    sig do
      params(
        sender: ::User,
        receiver: ::User,
        payload: ::Messaging::Models::MessagePayload
      ).returns(T.nilable(::Message))
    end
    def self.create_direct_message!(sender:, receiver:, payload:)
      message = T.let(nil, T.nilable(::Message))

      ::ActiveRecord::Base.transaction do
        # Find or Create conversation, we can find by
        # - participants (sender, receiver)
        # - or find by source_id
        # conversation = ::Conversation.joins(:participants)
        #   .where(:participants => {:user_id => sender.id})
        #   .where(:participants => {:user_id => receiver.id})
        #   .first
        conversation = Conversation.find_by(
          id: ::ConversationParticipant
                .where(:user_id => [sender.id, receiver.id])
                .group(:conversation_id)
                .having("count(*) = ?", [sender.id, receiver.id].count)
                .pluck(:conversation_id)
        )

        if conversation.blank?
          conversation = ::Conversation.create!(created_by: sender)
          # Create participants
          conversation.participants.create!(user: sender)
          conversation.participants.create!(user: receiver)
        end
        # create conversation participants
        # Create message
        message = conversation.messages.create!(
          source_id: payload.idempotency_key,
          message_type: payload.message_type.serialize,
          message_subtype: payload.message_subtype.serialize,
          source_reply_to_message_id: payload.reply_to_message_id,
          source_forward_from_user_id: nil,
          source_forward_from_conversation_id: nil,
          source_forward_from_message_id: nil,
          replied_to: payload.reply_to_message_id.present?,
          forwarded: false,
          body: payload.text,
          user: sender,
        )
      end

      ::Notifications::Service.notify! if message.present?
      
      message
    rescue ::ActiveRecord::RecordNotUnique => _
      nil
    end

    def self.create_event_group_message!
    end
  end
end
