require 'journey_log'

describe JourneyLog do
  let(:station) { double }

  it { expect(subject).to respond_to(:journeys) }
  it 'cannot alter journeys' do
    subject.start(station)
    subject.finish(station)
    subject.journeys[0] = 'asd'
    expect(subject.journeys[0]).not_to eq('asd')
  end

  context 'having started a journey' do
    before(:each) { subject.start(:station) }

    describe '#outstanding_charge' do
      it 'will return a number (penalty fare' do # the number will be decided by the journey class.
        expect(subject.outstanding_charge).to be_a(Number)
      end
      it 'will add a journey' do
        expect { subject.finish(station) }.to change { subject.journeys.count }.by 1
      end
    end

    describe '#finish' do
      it 'will add a journey' do
        expect { subject.finish(station) }.to change { subject.journeys.count }.by 1
      end
    end
  end
end
