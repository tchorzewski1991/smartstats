RSpec.describe SmartStats::IpCounter do
  it { is_expected.to be_kind_of(SmartStats::Counter) }

  describe '#track' do
    it 'should increment occurence by one when valid IP is given' do
      counter = described_class.new
      expect(counter.track('192.168.1.1')).to eq(1)
    end

    it 'should leave object untouched when invalid IP is given' do
      counter = described_class.new
      expect(counter.track('INVALID_IP')).to eq(nil)
    end
  end
end
