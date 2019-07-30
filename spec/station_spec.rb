require 'station'

describe Station do
  subject { described_class.new('Old Street', 2) }

  it 'returns da name zone' do
    expect(subject.name).to eq('Old Street')
  end
  it 'returns da zone zone' do
    expect(subject.zone).to eq(2)
  end
end
