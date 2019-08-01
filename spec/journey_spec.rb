require 'journey'

describe 'Journey' do
  let(:station) { double }
  subject { Journey.new }

  context 'new journey' do
    it { expect(subject.exit_station).to eq(nil) }
    it { expect(subject).not_to be_complete }

    it 'throws an error it try to complete it' do
      expect { subject.process_fare }.to raise_error(Journey::ERR_EMPTY_JOURNEY)
    end

    context 'add entry station' do
      subject { Journey.new(station) }
      it { expect(subject).not_to be_complete }
      it { expect(subject.entry_station).to eq(station) }

      it 'takes an exit station' do
        subject.exit_station = station
        expect(subject.exit_station).to eq(station)
      end

      context 'process fare' do
        it { expect(subject.process_fare).to eq(Journey::PENALTY_FARE) }
        it { subject.process_fare; expect(subject).to be_complete }
      end

      context 'add exit_station' do
        before(:each) { subject.exit_station = station }
        context 'process_fare' do
          it { expect(subject.process_fare).to eq(Journey::MINIMUM_FARE) }
          it { subject.process_fare; expect(subject).to be_complete }
        end
      end
    end

    context 'add exit station' do
      subject { Journey.new }
      before(:each) { subject.exit_station = station }
      it { expect(subject.entry_station).to eq(nil) }
      describe '#process_fare' do
        it { expect(subject.process_fare).to eq(Journey::PENALTY_FARE) }
      end
      context 'process_fare' do
        before(:each) { subject.process_fare }
        it { expect(subject).to be_complete }
        it { expect { subject.process_fare }.to raise_error(Journey::ERR_PROCESSING_COMPLETED_JOURNEY) }
      end
    end
  end
end
