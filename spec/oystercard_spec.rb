require 'oystercard'

describe 'Oystercard' do
  subject { Oystercard.new }

  it { is_expected.to respond_to(:balance) }
  it { is_expected.not_to respond_to(:deduct) }

  describe '.top_up' do
    before(:each) { subject = Oystercard.new(0) }

    it 'adds value to balance' do
      top_up_amount = rand(1..50)
      expect { subject.top_up(top_up_amount) }.to change { subject.balance }.by top_up_amount
    end

    it 'refuses to exceed balance limit' do
      top_up_amount = Oystercard::MAXIMUM_BALANCE + rand(1..100)
      expect { subject.top_up(top_up_amount) }.to raise_error(Oystercard::ERR_BALANCE_LIMIT)
    end

    it 'tops up to limit' do
      top_up_amount = Oystercard::MAXIMUM_BALANCE
      expect { subject.top_up(top_up_amount) }.to change { subject.balance }.by top_up_amount
    end
  end

  context 'with 0 starting balance' do
    subject { Oystercard.new }
    it 'begins with a 0 balance' do
      expect(subject.balance).to eq(0)
    end
  end

  context 'with rand() starting balance' do
    test_balance = rand(1..50)
    subject { Oystercard.new(test_balance) }

    it 'holds 100 balance' do
      expect(subject.balance).to eq(test_balance)
    end
  end

  it 'will not be initialized with balance over maximum' do
    expect { Oystercard.new(Oystercard::MAXIMUM_BALANCE + rand(1..100)) }.to raise_error Oystercard::ERR_BALANCE_LIMIT
  end

  describe '.in_journey?' do
    it 'has a default of not travelling' do
      expect(subject).not_to be_in_journey
    end

    it 'is travelling after touching in' do
      subject.top_up(90)
      subject.touch_in(:station)
      expect(subject).to be_in_journey
    end
  end

  describe '.touch_in' do
    let(:station) { double('station') }

    it 'raises error if less than minimum balance' do
      expect { Oystercard.new.touch_in(:station) }.to raise_error Oystercard::ERR_TOUCH_IN_NO_FUNDS
    end

    before(:each) { subject.top_up(90) }
    # before(:each) { cash_rich_rider.touch_in(:station) }

    it 'sets in_journey to true' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    # This is now the journey logs responsibility
    # it 'stores entry station' do
    #   subject.touch_in(station)
    #   expect(subject.journey.entry_station).to eq(station)
    # end
  end

  describe '.touch_out' do
    subject { Oystercard.new(90) }
    before(:each) { subject.touch_in(:station) }

    it 'sets in_journey to false' do
      subject.touch_out(:station)
      expect(subject).not_to be_in_journey
    end

    it 'deducts from balance' do
      p subject.in_journey?

      expect { subject.touch_out(:station) }.to change { subject.balance }.by(-Journey::MINIMUM_FARE)
    end
  end

  describe 'journeys' do
    it 'prints out an array of journeys?' do
      subject.top_up(90)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.journeys).to be_a(Array)
    end
  end
end
