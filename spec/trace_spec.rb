RSpec.describe SmartStats::Trace do
  let(:route) { 'route' }

  let!(:counter) do
    double(name: 'Counter', all_entries: 2, uniq_entries: 1, track: 1)
  end

  let(:trace) { described_class.new(route, counter) }

  describe 'when initialized' do
    it 'raises exception when arguments are missing' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'uses available reader to return correct route state' do
      expect(trace.route).to eq(route)
    end

    it 'uses available reader to return correct counter state' do
      expect(trace.counter.name).to eq(counter.name)
    end

    context 'when custom counter given' do
      let(:required_methods) { %i(all_entries uniq_entries) }

      it 'raises exception when custom counter does not define '\
      'expected behavior' do
        custom_counter = Class.new
        trace = described_class.new(route, custom_counter)
        expect do
          trace.send(required_methods.sample)
        end.to raise_error(NoMethodError)
      end

      it 'allows custom counter to be used when expected behavior is defined' do
        custom_counter = double(name: 'ValidCounter', all_entries: true,
                                uniq_entries: true, track: true)
        trace = described_class.new(route, custom_counter)
        index = rand(0..1)
        expect(
          trace.send(required_methods[index])
        ).to eq(custom_counter.send(required_methods[index]))
      end
    end
  end

  describe '#all_entries' do
    it 'delegates query for total number of entries to counter' do
      expect(trace.all_entries).to eq(counter.all_entries)
    end
  end

  describe '#uniq_entries' do
    it 'delegates query for unique number of entries to counter' do
      expect(trace.uniq_entries).to eq(counter.uniq_entries)
    end
  end

  describe '#track' do
    it 'delegates query for tracking given key to counter' do
      expect(counter).to receive(:track).with('key').and_return(1)
      trace.track('key')
    end
  end

  describe '#==' do
    it 'should explore objects equality by looking on their routes' do
      equal_trace = described_class.new('route', double('Counter'))
      expect(trace == equal_trace).to eq(true)
      not_equal_trace = described_class.new('other', double('Counter'))
      expect(trace == not_equal_trace).to eq(false)
    end
  end

  describe '#<=>' do
    it 'should compare objects position by looking on thier routes' do
      trace_a = described_class.new('/a', double('Counter'))
      trace_b = described_class.new('/b', double('Counter'))
      expect(trace_a <=> trace_b).to eq(-1)
      expect(trace_b <=> trace_a).to eq(1)
    end
  end

  describe '#to_a(property = :all_entries)' do
    it 'returns array projection for :all_entries for invalid property' do
      expected = ['route', counter.all_entries]
      expect(trace.to_a(:incorrect)).to eq(expected)
    end

    it 'returns correct array projection when :uniq_entries given' do
      expected = ['route', counter.uniq_entries]
      expect(trace.to_a(:uniq_entries)).to eq(expected)
    end
  end
end
