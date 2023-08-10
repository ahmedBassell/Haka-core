require "rails_helper"

RSpec.describe ::Messaging::Service do
  let!(:member) { FactoryBot.create(:user, :member) }
  let!(:owner) { FactoryBot.create(:user, :owner) }
  let!(:another_member) { FactoryBot.create(:user, :member) }
  let!(:another_owner) { FactoryBot.create(:user, :owner) }

  shared_examples_for "when conversation does not exist (first message)" do
    it "Should persist a conversation record" do
      expect { subject }.to change { ::Conversation.count }.by(1)
    end

    it "Should persist 2 conversation participants records" do
      expect { subject }.to change { ::ConversationParticipant.count }.by(2)
    end

    it "Should persist a message record" do
      expect { subject }.to change { ::Message.count }.by(1)
    end

    it "Should trigger push notification" do
      expect(::Notifications::Service).to receive(:notify!)
      subject
    end
  end

  shared_examples_for "when conversation already exists" do
    let!(:conversation) { ::Conversations::Service.create_one_on_one!(first_user_id: user_one.id, second_user_id: user_two.id) }
    let!(:participant_one) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: user_one) }
    let!(:participant_two) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: user_two) }
    # other conversations that might have common participants
    let!(:noise_conversation_one) { ::FactoryBot.create(:conversation, created_by: user_one) }
    let!(:noise_conversation_two) { ::FactoryBot.create(:conversation, created_by: user_two) }
    let!(:noise_participant_one) { ::FactoryBot.create(:conversation_participant, conversation: noise_conversation_one, user: user_one) }
    let!(:noise_participant_one) { ::FactoryBot.create(:conversation_participant, conversation: noise_conversation_two, user: user_two) }

    it "Should not persist a new conversation record" do
      expect { subject }.to change { ::Conversation.count }.by(0)
    end

    it "Should not persist 2 conversation participants records" do
      expect { subject }.to change { ::ConversationParticipant.count }.by(0)
    end

    it "Should persist a message record" do
      expect { subject }.to change { ::Message.count }.by(1)
    end

    it "Should trigger push notification" do
      expect(::Notifications::Service).to receive(:notify!)
      subject
    end
  end

  shared_examples_for "when a duplicate message is sent with same source_id" do
    let!(:conversation) { ::Conversations::Service.create_one_on_one!(first_user_id: user_one.id, second_user_id: user_two.id) }
    let!(:participant_one) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: user_one) }
    let!(:participant_two) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: user_two) }
    let!(:message) { ::FactoryBot.create(:message, conversation: conversation, user: user_one, source_id: idempotency_key) }

    it "Should not persist a new conversation record" do
      expect { subject }.to change { ::Conversation.count }.by(0)
    end

    it "Should not persist 2 conversation participants records" do
      expect { subject }.to change { ::ConversationParticipant.count }.by(0)
    end

    it "Should not persist a message record" do
      expect { subject }.to change { ::Message.count }.by(0)
    end

    it "Should not trigger push notification" do
      expect(::Notifications::Service).not_to receive(:notify!)
      subject
    end
  end

  shared_examples_for "When payload is text message" do
    let(:text_body) { "Hello 👋!" }
    let(:idempotency_key) { "0" }
    let(:payload) do
      ::Messaging::Models::Payloads::Text.new(
        text: text_body,
        conversation_type: ::Conversations::Models::Enums::ConversationType::OneOnOne,
        message_type: ::Messaging::Models::Enums::MessageType::Text,
        message_subtype: ::Messaging::Models::Enums::MessageSubtype::No_Subtype,
        idempotency_key: idempotency_key,
        reply_to_message_id: nil,
        sender: user_one,
        receiver: user_two
      )
    end

    it_behaves_like "when conversation does not exist (first message)"
    it_behaves_like "when conversation already exists"
    it_behaves_like "when a duplicate message is sent with same source_id"
  end


  # Waiting
  shared_examples_for "when conversation already exists before waiting message" do
    let!(:conversation) { ::Conversations::Service.create_one_on_one!(first_user_id: user_one.id, second_user_id: user_two.id) }

    it "Should not persist a new conversation record" do
      expect { subject }.to change { ::Conversation.count }.by(0)
    end

    it "Should persist a message record" do
      expect { subject }.to change { ::Message.count }.by(1)
    end

    it "Should trigger push notification" do
      expect(::Notifications::Service).to receive(:notify!)
      subject
    end
  end

  shared_examples_for "When payload is waiting message" do
    let(:user_one) { member }
    let(:user_two) { event.created_by }
    let(:idempotency_key) { "0" }
    let(:payload) do
      ::Messaging::Models::Payloads::Waiting.new(
        conversation_type: ::Conversations::Models::Enums::ConversationType::OneOnOne,
        user: user_one,
        event: event,
        idempotency_key: idempotency_key,
      )
    end

    it_behaves_like "when conversation does not exist (first message)"
    it_behaves_like "when conversation already exists before waiting message"
    it_behaves_like "when conversation already exists"
    it_behaves_like "when a duplicate message is sent with same source_id"
  end
  
  describe ".create_direct_message!" do
    subject do
      described_class.create_message!(payload: payload)
    end

    context "When sender is owner" do
      let(:user_one) { owner }
      
      context "When receiver is owner" do
        let(:user_two) { another_owner }
        
        it_behaves_like "When payload is text message"
      end

      context "When receiver is member" do
        let(:user_two) { member }
        
        it_behaves_like "When payload is text message"
      end
    end

    context "When sender is a member" do
      let(:user_one) { member }
      context "When receiver is owner" do
        let(:user_two) { owner }

        it_behaves_like "When payload is text message"
      end

      context "When receiver is member" do
        let(:user_two) { another_member }

        it_behaves_like "When payload is text message"
      end
    end
  end

  describe ".create_event_group_message!" do
  end


  # First make user_id polymorphism betweern users and bot users, then change spec to adapt to bot_user_id for message user_id
  describe ".create_system_message!" do
    subject do
      described_class.create_message!(payload: payload)
    end

    context "When waiting system message is created" do
      let!(:event) { FactoryBot.create(:event) }
      
      it_behaves_like "When payload is waiting message"
    end
  end
end
