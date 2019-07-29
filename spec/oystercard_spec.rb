require 'oystercard'

describe 'Oystercard' do
  subject { Oystercard.new }
  it { is_expected.to respond_to(:balance) }

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

  describe '.deduct(amount)' do
    before(:each) { subject = Oystercard.new(50) }
    it 'deducts a small value' do
      deduct_value = rand(1..49)
      pre_balance = subject.balance
      expect { subject.deduct(deduct_value) }.to change { subject.balance }.by -deduct_value
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
end
