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
    let!(:conversation) { ::FactoryBot.create(:conversation, created_by: sender) }
    let!(:participant_one) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: sender) }
    let!(:participant_two) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: receiver) }
    # other conversations that might have common participants
    let!(:noise_conversation_one) { ::FactoryBot.create(:conversation, created_by: sender) }
    let!(:noise_conversation_two) { ::FactoryBot.create(:conversation, created_by: receiver) }
    let!(:noise_participant_one) { ::FactoryBot.create(:conversation_participant, conversation: noise_conversation_one, user: sender) }
    let!(:noise_participant_one) { ::FactoryBot.create(:conversation_participant, conversation: noise_conversation_two, user: receiver) }

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
    let!(:conversation) { ::FactoryBot.create(:conversation, created_by: sender) }
    let!(:participant_one) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: sender) }
    let!(:participant_two) { ::FactoryBot.create(:conversation_participant, conversation: conversation, user: receiver) }
    let!(:message) { ::FactoryBot.create(:message, conversation: conversation, user: sender, source_id: idempotency_key) }

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
        message_type: ::Messaging::Models::Enums::MessageType::Text,
        message_subtype: ::Messaging::Models::Enums::MessageSubtype::No_Subtype,
        idempotency_key: idempotency_key,
        reply_to_message_id: nil,
      )
    end

    it_behaves_like "when conversation does not exist (first message)"
    it_behaves_like "when conversation already exists"
    it_behaves_like "when a duplicate message is sent with same source_id"
  end
  
  describe ".create_direct_message!" do
    subject do
      described_class.create_direct_message!(sender: sender, receiver: receiver, payload: payload)
    end

    context "When sender is owner" do
      let(:sender) { owner }
      
      context "When receiver is owner" do
        let(:receiver) { another_owner }
        
        it_behaves_like "When payload is text message"
      end

      context "When receiver is member" do
        let(:receiver) { member }
        
        it_behaves_like "When payload is text message"
      end
    end

    context "When sender is a member" do
      let(:sender) { member }
      context "When receiver is owner" do
        let(:receiver) { owner }

        it_behaves_like "When payload is text message"
      end

      context "When receiver is member" do
        let(:receiver) { another_member }

        it_behaves_like "When payload is text message"
      end
    end
  end

  describe ".create_event_group_message!" do
  end
end
