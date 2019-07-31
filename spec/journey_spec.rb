require 'journey'

describe 'Journey' do
  let(:station) { double }
  subject { Journey.new(station) }

  it 'is not complete to start with' do
    expect(subject).not_to be_complete
  end

  context 'a completed journey' do
    before(:each) { subject.exit_station = station }
    before(:each) { subject.process_fare }
    it 'cannot be processed again' do
      expect { subject.process_fare }.to raise_error Journey::ERR_PROCESSING_COMPLETED_JOURNEY
    end
    it 'cannot have exit station changed' do
      expect { subject.exit_station = station }.to raise_error Journey::ERR_PROCESSING_COMPLETED_JOURNEY
    end
    it 'have a fare with a number' do
      expect(subject.fare).to be_a(Numeric)
    end
  end

  context 'With entry and no exit station' do
    it 'takes an exit station' do
      subject.exit_station = station
    end

    it 'calcs a penalty fare and marks as completed' do
      expect(subject.process_fare).to eq(Journey::PENALTY_FARE)
      expect(subject).to be_complete
    end
  end

  context 'with entry and exit station' do
    before(:each) { subject.exit_station = station }

    it 'calcs a normal fare and marks as completed' do
      expect(subject.process_fare).to eq(Journey::MINIMUM_FARE)
      expect(subject).to be_complete
    end
  end

  context 'without entry and with exit station' do
    subject { Journey.new }

    it 'returns penalty fare on exit' do
      subject.exit_station = station
      expect(subject.process_fare).to eq(Journey::PENALTY_FARE)
      expect(subject).to be_complete
    end

    it { expect(subject.exit_station).to eq(nil) }
  end

  context 'with out any station' do
    subject { Journey.new }

    it { expect(subject.exit_station).to eq(nil) }

    it 'throws an error it try to complete it' do
      expect { subject.process_fare }.to raise_error(Journey::ERR_EMPTY_JOURNEY)
    end
  end
end
