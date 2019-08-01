require 'oystercard'

describe Oystercard do
  # let(:in_prog_journey) { double(:journey, start: 1, complete: false) }
  # let(:outstanding_class) { double(:journey_log, outstanding_charge: 1, end: 1, start: :in_prog_journey, current_journey: 1) }

  let(:station) { double(:station) }
  let(:journey) { double(:journey) }
  let(:journey_log_new) { double(:journey_log_new, current_journey: nil, start: Oystercard::MAXIMUM_BALANCE, end: 1, journeys: [journey], outstanding_charge: 0) }
  let(:journey_log_class) { double(:journey_log_class, new: journey_log_new) }

  let(:rand_max) { rand(1..Oystercard::MAXIMUM_BALANCE) }
  let(:rand_max_plus) { Oystercard::MAXIMUM_BALANCE + rand(1..100) }

  context 'with no money' do
    subject { Oystercard.new(0, journey_log_class) }

    it 'begins with a 0 balance' do
      expect(subject.balance).to eq(0)
    end

    it 'begins with 0 journeys' do
      allow(journey_log_new).to receive(:journeys). and_return([])
      expect(subject.journeys).to eq([])
    end

    it 'adds value to balance' do
      expect { subject.top_up(rand_max) }.to change { subject.balance }.by rand_max
    end

    it 'refuses to exceed balance limit' do
      expect { subject.top_up(rand_max_plus) }.to raise_error(Oystercard::ERR_BALANCE_LIMIT)
    end

    it 'will not be initialized with balance over maximum' do
      expect { Oystercard.new(rand_max_plus) }.to raise_error Oystercard::ERR_BALANCE_LIMIT
    end

    it 'has a default of not travelling' do
      # allow(journey_log_new).to receive(:journeys). and_return([])
      expect(subject).not_to be_in_journey
    end

    it 'cant touch in with low funds' do
      expect { subject.touch_in(:station) }.to raise_error Oystercard::ERR_TOUCH_IN_NO_FUNDS
    end
  end

  context 'with money' do
    subject { Oystercard.new(Oystercard::MAXIMUM_BALANCE, journey_log_class) }

    it 'returns balance on touch in' do
      expect(subject.touch_in(station)).to eq(Oystercard::MAXIMUM_BALANCE)
    end

    context 'and touched_in' do
      before(:each) { subject.touch_in(station) }

      it 'is in journey' do
        allow(journey_log_new).to receive(:current_journey). and_return(journey)
        expect(subject).to be_in_journey
      end

      it 'deducts from balance if starting a new journey' do
        allow(journey_log_new).to receive(:outstanding_charge). and_return(rand_max)
        expect { subject.touch_in(station) }.to change { subject.balance }.by -rand_max
      end

      it 'deducts from balance if touching out' do
        allow(journey_log_new).to receive(:end). and_return(rand_max)
        expect { subject.touch_out(station) }.to change { subject.balance }.by -rand_max
      end
    end
  end
end
