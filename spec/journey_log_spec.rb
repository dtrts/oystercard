require 'journey_log'

describe JourneyLog do
  let(:station) { double }

  it { expect(subject).to respond_to(:journeys) }

  context 'empty log' do
    it 'has journeys as empty array' do
      expect(subject.journeys).to be_empty
      expect(subject.journeys).to be_a(Array)
    end
    it 'has nil current journey' do
      expect(subject.current_journey).to eq(nil)
    end
  end

  context 'having started a journey' do
    before(:each) { subject.start(:station) }

    describe '#outstanding_charge' do
      it 'will return a number (penalty fare)' do # the number will be decided by the journey class.
        expect(subject.outstanding_charge).to be_a(Numeric)
      end
    end

    describe '#end' do
      it 'will add a journey' do
        expect { subject.end(station) }.to change { subject.journeys.count }.by 1
      end

      it 'will add a journey' do
        expect { subject.end(station) }.to change { subject.journeys.count }.by 1
      end
    end

    let(:station2) { double('station2') }
    it 'cant alter current journey directly' do
      subject.current_journey.exit_station = station2
      expect(subject.current_journey.exit_station).not_to eq(station2)
    end
  end

  context 'having a completed journey in log' do
    before(:each) { subject.start(:station) }
    before(:each) { subject.end(:station) }

    it { expect(subject.journeys.count).to eq(1) }
    it 'cannot alter journeys' do
      subject.journeys[0] = 'asd'
      expect(subject.journeys[0]).not_to eq('asd')
    end
  end
end
