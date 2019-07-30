require 'station'

describe 'Station' do
  subject { Station.new('Old Street', 2) }

  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:zone) }
end
