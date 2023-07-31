require "rails_helper"

RSpec.describe ::EventParticipants::Service do
  let!(:member) { FactoryBot.create(:user, :member) }
  let!(:another_member) { FactoryBot.create(:user, :member) }
  let!(:owner) { FactoryBot.create(:user, :owner) }
  

  shared_examples_for "when a member perform unauthorized action" do
    let(:user) { member }

    it "Should not allow member to create an event" do
      expect{ subject }.to raise_error(::Users::Errors::Unauthorized)
    end
  end

  describe ".update_status!" do
    let!(:event_participant) { FactoryBot.create(:event_participant) } # CREATE factory for event participant
    let(:status) { ::ParticipantStatusEnum.from_serialized(::PARTICIPANT_STATUS_CONFIRMED) }

    subject do
      described_class.update_status!(
        event_participant: event_participant,
        status: status,
        update_by: user
      )
    end

    context "When a member updates an event participant" do
      it_behaves_like "when a member perform unauthorized action"
    end

    context "When an owner creates an event participant" do
      let(:user) { owner }

      context "When status change to be confirmed" do
        it "Should not allow creating event" do
          expect { subject }.to change { event_participant.status }.from(::PARTICIPANT_STATUS_WAITING.to_s).to(::PARTICIPANT_STATUS_CONFIRMED.to_s)
        end
      end
    end
  end
end