RSpec.describe ::Events::Service do
  let(:member) { FactoryBot.create(:user, :member) }
  let(:owner) { FactoryBot.create(:user, :owner) }

  shared_examples_for "when a member perform unauthorized action" do
    let(:user) { member }

    it "Should not allow member to create an event" do
      expect{ subject }.to raise_error(::Users::Errors::Unauthorized)
    end
  end

  describe ".create!" do
    let(:event_name) { "kAHA SUN 8-10 PM" }
    let(:description) { "🤾🤾🤾" }
    let(:category) { ::Events::Models::Enums::CategoryType::KahaGame }
    let(:date) { 2.days.from_now.to_date }
    let(:from) { date.to_datetime.change(hour: 10) }
    let(:to) { date.to_datetime.change(hour: 12) }

    subject do
      described_class.create!(
        name: event_name,
        description: description,
        category: category,
        created_by: user,
        date: date,
        from: from,
        to: to
      )
    end

    context "When a member creates an event" do
      it_behaves_like "when a member perform unauthorized action"
    end

    context "When an owner creates an event" do
      let(:user) { owner }

      context "When event date is today or in past" do
        let(:date) { 2.days.ago.to_date }

        it "Should not allow creating event" do
          expect{ subject }.to raise_error(::Events::Errors::InvalidDate)
        end
      end

      context "When event date from time is ahead of to time" do
        let(:from) { date.to_datetime.change(hour: 12) }
        let(:to) { date.to_datetime.change(hour: 10) }
        
        it "Should not allow creating event" do
          expect{ subject }.to raise_error(::Events::Errors::InvalidTime)
        end
      end

      context "When happy scenario" do
        it "Should persist an event record" do
          expect { subject }.to change { ::Event.count }.by(1)
        end
      end
    end
  end

  describe ".update!" do
    subject do
      described_class.update!(
        event_id: event_id,
        updated_by: user,
        display_name: new_display_name,
        description: new_description,
        category: new_category,
        date: new_date,
        from: new_from,
        to: new_to,
        longitude: new_longitude,
        latitude: new_latitude
      )
    end

    let!(:event) { FactoryBot.create(:event) }
    let(:event_id) { event.id }
    let(:new_display_name) { "Latest name" }
    let(:new_description) { "latest description" }
    let(:new_category) { ::Events::Models::Enums::CategoryType::RegionalAdv }
    let(:new_date) { 10.days.from_now.utc.to_date }
    let(:new_from) { new_date.to_datetime.change(hour: 0) }
    let(:new_to) { new_date.to_datetime.change(hour: 8) }
    let(:new_longitude) { 10.0 }
    let(:new_latitude) { 10.0 }

    context "When a member updates an event" do
      it_behaves_like "when a member perform unauthorized action"
    end

    context "When an owner updates an event" do
      let(:user) { owner }

      context "When event date is today or in past" do
        let(:new_date) { 2.days.ago.to_date }

        it "Should not allow creating event" do
          expect{ subject }.to raise_error(::Events::Errors::InvalidDate)
        end
      end

      context "When event date from time is ahead of to time" do
        let(:new_from) { new_date.to_datetime.change(hour: 12) }
        let(:new_to) { new_date.to_datetime.change(hour: 10) }

        it "Should not allow creating event" do
          expect{ subject }.to raise_error(::Events::Errors::InvalidTime)
        end
      end

      context "When event does not exist" do
        let(:event_id) { 0 }

        it "Should raise a not found error" do
          expect{ subject }.to raise_error(::ActiveRecord::RecordNotFound)
        end
      end

      context "When event is cancelled" do
        let!(:event) { FactoryBot.create(:event, :canceled) }
      
        it "Should raise already canceled error" do
          expect{ subject }.to raise_error(::Events::Errors::AlreadyCanceled)
        end
      end

      context "When event exists (happy scenario)" do
        it "Should updates event attributes" do
          subject
          event.reload
          expect(event.display_name).to eq(new_display_name)
          expect(event.description).to eq(new_description)
          expect(event.category).to eq(new_category.serialize.to_s)
          expect(event.date).to eq(new_date)
          expect(event.from).to eq(new_from)
          expect(event.to).to eq(new_to)
          expect(event.longitude).to eq(new_longitude)
          expect(event.latitude).to eq(new_latitude)
        end
      end
    end
  end

  describe ".cancel!" do
    subject do
      described_class.cancel!(
        event_id: event_id,
        canceled_by: user
      )
    end

    context "When a member cancels an event" do
      let!(:event) { FactoryBot.create(:event) }
      let(:event_id) { event.id }
      let(:user) { member }

      it_behaves_like "when a member perform unauthorized action"
    end

    context "When an owner cancels an event" do
      let!(:event) { FactoryBot.create(:event, :canceled) }
      let(:event_id) { event.id }
      let(:user) { owner }

      context "When event is already canceled" do
        it "Should raise already canceled error" do
          expect{ subject }.to raise_error(::Events::Errors::AlreadyCanceled)
        end
      end

      context "When event does not exist" do
        let(:event_id) { 0 }

        it "Should raise a not found error" do
          expect{ subject }.to raise_error(::ActiveRecord::RecordNotFound)
        end
      end

      context "When event exists (happy scenario)" do
        let!(:event) { FactoryBot.create(:event) }
        
        it "Should update event to be canceled" do
          subject
          expect(event.reload).to be_canceled
        end
      end
    end
  end

  describe ".uncancel!" do
    subject do
      described_class.uncancel!(
        event_id: event_id,
        uncanceled_by: user
      )
    end
    context "When a member uncancels an event" do
      let!(:event) { FactoryBot.create(:event, :canceled) }
      let(:event_id) { event.id }
      let(:user) { member }

      it_behaves_like "when a member perform unauthorized action"
    end

    context "When an owner uncancels an event" do
      let(:user) { owner }

      context "When event is already uncanceled" do
        let!(:event) { FactoryBot.create(:event) }
        let(:event_id) { event.id }
      
        it "Should raise already uncanceled error" do
          expect{ subject }.to raise_error(::Events::Errors::AlreadyUnCanceled)
        end
      end

      context "When event does not exist" do
        let(:event_id) { 0 }

        it "Should raise a not found error" do
          expect{ subject }.to raise_error(::ActiveRecord::RecordNotFound)
        end
      end

      context "When canceled event exists (happy scenario)" do
        let!(:event) { FactoryBot.create(:event, :canceled) }
        let(:event_id) { event.id }

        it "Should update event to be uncanceled" do
          subject
          expect(event.reload).not_to be_canceled
        end
      end
    end
  end

  describe ".destroy!" do
    subject do
      described_class.destroy!(
        event_id: event_id,
        destroyed_by: user
      )
    end

    context "When a member destroys an event" do
      let!(:event) { FactoryBot.create(:event) }
      let(:event_id) { event.id }

      it_behaves_like "when a member perform unauthorized action"
    end

    context "When an owner destroys an event" do
      let(:user) { owner }

      context "When event does not exist" do
        let(:event_id) { 0 }

        it "Should raise a not found error" do
          expect{ subject }.to raise_error(::ActiveRecord::RecordNotFound)
        end
      end

      context "When event exists (happy scenario)" do
        let!(:event) { FactoryBot.create(:event) }
        let(:event_id) { event.id }

        it "Should soft delete event" do
          subject
          expect(event.reload).to be_discarded
        end
      end
    end
  end
end