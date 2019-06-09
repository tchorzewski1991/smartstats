RSpec.describe SmartStats::Visits do
  let(:set) { subject }

  let!(:index_trace) do
    double(route: :'/index', all_entries: 3, uniq_entries: 2, :<=> => 1)
  end

  let!(:about_trace) do
    double(route: :'/about', all_entries: 2, uniq_entries: 1, :<=> => -1)
  end

  describe 'when initialized' do
    it { is_expected.to be_kind_of(Set) }
    it { is_expected.to be_empty }

    it 'should skip all arguments given to constructor' do
      expect(described_class.new('1', 2, [], {})).to be_empty
    end
  end

  describe '#all_traces' do
    context 'when set is empty' do
      it 'expects to return empty Array' do
        expect(subject.all_traces).to be_empty
        expect(subject.uniq_traces).to be_kind_of(Array)
      end
    end

    context 'when traces are present' do
      let!(:expected) { [['/about', 3], ['/index', 2]] }

      before do
        allow(index_trace).to receive(:to_a).and_return(expected[1])
        allow(about_trace).to receive(:to_a).and_return(expected[0])
        set << index_trace << about_trace
      end

      it 'returns ordered array with all traces and their occurences' do
        expect(set.all_traces).to eq(expected)
      end
    end
  end

  describe '#uniq_traces' do
    context 'when set is empty' do
      it 'expects to return empty Array' do
        expect(subject.uniq_traces).to be_empty
        expect(subject.uniq_traces).to be_kind_of(Array)
      end
    end

    context 'when traces are present' do
      let(:expected) { [['/about', 2], ['/index', 1]] }

      before do
        allow(index_trace).to receive(:to_a).and_return(expected[1])
        allow(about_trace).to receive(:to_a).and_return(expected[0])
        set << index_trace << about_trace
      end

      it 'returns ordered array of unique traces and their occurences' do
        expect(set.uniq_traces).to eq(expected)
      end
    end
  end
end
