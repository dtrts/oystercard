require 'journey_log'

describe JourneyLog do
  let(:station) { double(:station) }
  let(:journey) { double(:journey, :exit_station= => station, process_fare: 0) }
  let(:journey_class) { double(:journey_class, new: journey) }

  subject { JourneyLog.new(journey_class) }

  it { expect(subject).to respond_to(:journeys) }

  context 'empty log' do
    describe '#journeys' do
      it 'is empty' do
        expect(subject.journeys).to be_empty
        expect(subject.journeys).to be_a(Array)
      end
    end
    describe '#current_journey' do
      it 'is nil' do
        expect(subject.current_journey).to eq(nil)
      end
    end
  end

  context 'having started a journey' do
    before(:each) { subject.start(station) }

    describe '#outstanding_charge' do
      it 'will return a number (penalty fare)' do
        # the number will be decided by the journey class which we have mocked
        # normally it would be non-zero
        expect(subject.outstanding_charge).to eq(0)
      end
    end

    describe '#end' do
      it 'will add a journey' do
        expect { subject.end(station) }.to change { subject.journeys.count }.by 1
      end
    end

    context 'and completed the journey' do
      before(:each) { subject.end(station) }

      it { expect(subject.journeys.count).to eq(1) }

      it 'cannot alter journeys' do
        subject.journeys[0] = 'asd'
        expect(subject.journeys[0]).not_to eq('asd')
      end

      describe '#outstanding_charge' do
        it 'returns 0' do
          expect(subject.outstanding_charge).to eq(0)
        end
      end
    end
  end
end
