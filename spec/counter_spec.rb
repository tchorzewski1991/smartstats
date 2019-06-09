RSpec.describe SmartStats::Counter do
  describe 'when initialized' do
    it { is_expected.to be_kind_of(Hash) }
    it { is_expected.to be_empty }

    it 'should skip all arguments given to constructor' do
      expect(described_class.new('1', 2, [], {})).to be_empty
    end

    it 'should have default_proc already set' do
      expect(subject.default_proc).not_to eq(nil)
    end
  end

  describe '#all_entries' do
    it 'should return 0 when no previous entries were specified' do
      expect(subject.all_entries).to eq(0)
    end

    it 'should return sum of all present entries' do
      counter = subject.tap do |c|
        %i[first first second].each { |key| c.track(key) }
      end
      expect(counter.all_entries).to eq(3)
    end
  end

  describe '#uniq_entries' do
    it 'should return 0 when no previous entries were specified' do
      expect(subject.uniq_entries).to eq(0)
    end

    it 'should return sum of all unique entries' do
      counter = subject.tap do |c|
        %i[first first second].each { |key| c.track(key) }
      end
      expect(counter.uniq_entries).to eq(2)
    end
  end

  describe '#track()' do
    context 'when given key is truthy' do
      it 'should increment occurence of the key' do
        expect(subject.key?(:any)).to eq(false)
        expect(subject.track(:any)).to eq(1)
        expect(subject.key?(:any)).to eq(true)
        expect(subject.track(:any)).to eq(2)
      end
    end

    context 'when given key is falsely' do
      it 'should leave object state untouched and return nil' do
        expect(subject.keys.any?).to eq(false)
        expect(subject.track(nil)).to eq(nil)
        expect(subject.keys.any?).to eq(false)
      end
    end
  end
end
