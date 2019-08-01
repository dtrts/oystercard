require 'oystercard'

describe Oystercard do
  # let(:in_prog_journey) { double(:journey, start: 1, complete: false) }
  # let(:outstanding_class) { double(:journey_log, outstanding_charge: 1, end: 1, start: :in_prog_journey, current_journey: 1) }

  let(:rand_max) { rand(1..Oystercard::MAXIMUM_BALANCE) }
  let(:rand_max_plus) { Oystercard::MAXIMUM_BALANCE + rand(1..100) }
  let(:station) { double(:station) }
  let(:journey) { double(:journey) }
  let(:journey_log) { double(:journey_log, start: Oystercard::MAXIMUM_BALANCE, outstanding_charge: 0) }
  let(:journey_log_class) { double(:journey_log_class, new: journey_log) }

  it 'will not be initialized with balance over maximum' do
    expect { Oystercard.new(rand_max_plus) }.to raise_error Oystercard::ERR_BALANCE_LIMIT
  end

  # The test on return values is done in journey_log_spec.

  context 'with no money' do
    subject { Oystercard.new(0, journey_log_class) }

    describe '#in_journey?' do
      it 'double negates the return from journey_log.current_journey' do
        allow(journey_log).to receive(:current_journey). and_return(nil)
        expect(subject.in_journey?).to eq(false)
      end
      it 'calls current_journey on journey_log' do
        expect(journey_log).to receive(:current_journey)
        subject.in_journey?
      end
    end
    describe 'journeys' do
      it 'sends message :journeys to the journey_log' do
        allow(journey_log).to receive(:journeys). and_return('test_response')
        expect(subject.journeys).to eq('test_response')
      end
      it 'calls journeys on journey log' do
        expect(journey_log).to receive(:journeys)
        subject.journeys
      end
    end

    describe ' # top_up' do
      it 'adds to balance' do
        expect { subject.top_up(rand_max) }.to change { subject.balance }.by rand_max
      end

      it 'refuses to exceed balance limit' do
        expect { subject.top_up(rand_max_plus) }.to raise_error(Oystercard::ERR_BALANCE_LIMIT)
      end
    end

    it 'cant touch in with low funds' do
      expect { subject.touch_in(station) }.to raise_error Oystercard::ERR_TOUCH_IN_NO_FUNDS
    end
  end

  context 'with money' do
    subject { Oystercard.new(Oystercard::MAXIMUM_BALANCE, journey_log_class) }

    it 'returns balance on touch in' do
      expect(subject.touch_in(station)).to eq(Oystercard::MAXIMUM_BALANCE)
    end

    it 'calls outstanding chard and start on entry station' do
      expect(journey_log).to receive(:outstanding_charge)
      expect(journey_log).to receive(:start).with(station)
      subject.touch_in(station)
    end

    context 'and touched_in' do
      before(:each) { subject.touch_in(station) }

      it 'deducts from balance if starting a new journey' do
        allow(journey_log).to receive(:outstanding_charge). and_return(rand_max)
        expect(journey_log).to receive(:outstanding_charge)
        expect(journey_log).to receive(:start)
        expect { subject.touch_in(station) }.to change { subject.balance }.by -rand_max
      end

      it 'deducts from balance if touching out' do
        allow(journey_log).to receive(:end). and_return(rand_max)
        expect { subject.touch_out(station) }.to change { subject.balance }.by -rand_max
      end

      it 'calls journey log to end with station' do
        allow(journey_log).to receive(:end). and_return(rand_max)
        expect(journey_log).to receive(:end).with(station)
        subject.touch_out(station)
      end
    end
  end
end
