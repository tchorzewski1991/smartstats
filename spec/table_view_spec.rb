RSpec.describe SmartStats::TableView do
  let!(:defaults) { described_class::DEFAULTS }

  describe 'when initialized' do
    %i(title headings rows style).each do |attribute|
      it "fallbacks to default when #{attribute} param is missing" do
        expect(subject.send(attribute)).to eq(defaults[attribute])
      end
    end

    context 'when style param is present' do
      let!(:default_all_separators) { defaults[:style][:all_separators] }

      it 'ensures :all_separators key will always be present' do
        table_view = described_class.new(style: {})
        expect(
          table_view.style[:all_separators]
        ).to eq(default_all_separators)
      end

      it 'allows to overwrite :all_separators key' do
        table_view = described_class.new(style: { all_separators: false })
        expect(
          table_view.style[:all_separators]
        ).not_to eq(default_all_separators)
      end

      it 'permits any custom style key' do
        table_view = described_class.new(style: { custom: 'custom' })
        expect(
          table_view.style[:custom]
        ).to eq('custom')
      end
    end
  end

  describe '#to_hash' do
    it 'returns new hash projection' do
      expect(subject.to_hash).to be_an_instance_of(Hash)
    end

    it 'contains exactly keys expected by Terminal::Table class constructor' do
      expect(subject.to_h.keys).to contain_exactly(
        :title, :headings, :rows, :style
      )
    end

    it "allows instance of #{described_class.name} to be treated as a Hash" do
      expect { {}.merge(subject) }.not_to raise_error
    end
  end

  describe '#to_h' do
    it 'is an alias of to_hash' do
      expect(subject.method(:to_h)).to eq(subject.method(:to_hash))
    end
  end
end
