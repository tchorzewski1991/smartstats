RSpec.describe SmartStats::FileLoader do
  describe 'when initialized' do
    let!(:mock_paths) do
      {
        valid: 'spec/fixtures/mock.log',
        invalid: 'spec/fixtures/mock.txt',
        missing: 'spec/fixtures/missing.whatever',
      }
    end

    it 'expects to be kind of File' do
      expect(described_class.new(mock_paths[:valid])).to be_kind_of(File)
    end

    it 'returns exception when file under path has invalid extension' do
      expect do
        described_class.new(mock_paths[:invalid])
      end.to raise_error(described_class::FileExtError)
    end

    it 'returns exception when file under path is not found' do
      expect do
        described_class.new(mock_paths[:missing])
      end.to raise_error(described_class::FileNotFoundError)
    end
  end
end
