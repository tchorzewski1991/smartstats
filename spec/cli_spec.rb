RSpec.describe SmartStats::CLI do
  let(:output) do
    lambda do |command, *args|
      capture(:stdout) do
        args.any? ? subject.send(command, *args) : subject.send(command)
      end
    end
  end

  describe '#version' do
    it 'returns actual smartstats version' do
      expect(output.(:version).strip).to eq(SmartStats::VERSION)
    end
  end

  describe '#parse' do
    context 'when path argument is missing' do
    end

    context 'when path argument is present' do
      it 'returns empty table stream when file is empty' do
        all_traces_table = terminal_table_stream(table_view_hash(
          title: 'All Traces'
        ))
        uniq_traces_table = terminal_table_stream(table_view_hash(
          title: 'Uniq Traces'
        ))
        mock_path = 'spec/fixtures/empty.log'
        expected_stream = [all_traces_table, uniq_traces_table].join("\n")
        expect(output.(:parse, mock_path).strip).to eq(expected_stream)
      end

      it 'returns expected table stream for parsed file content' do
        all_traces_table = terminal_table_stream(table_view_hash(
          title: 'All Traces', rows: [['/about', 1], ['/index', 2]]
        ))
        uniq_traces_table = terminal_table_stream(table_view_hash(
          title: 'Uniq Traces', rows: [['/about', 1], ['/index', 1]]
        ))
        mock_path = 'spec/fixtures/mock.log'
        expected_stream = [all_traces_table, uniq_traces_table].join("\n")
        expect(output.(:parse, mock_path).strip).to eq(expected_stream)
      end

      it 'returns error stream when file is missing' do
        mock_path = 'spec/fixtures/missing'
        expected_stream = "Err: File #{mock_path} not found"
        expect(output.(:parse, mock_path).strip).to eq(expected_stream)
      end

      it 'returns error stream when file has unsupported extension' do
        mock_path = 'spec/fixtures/mock.txt'
        expected_stream = "Err: File #{mock_path} has unsupported extension"
        expect(output.(:parse, mock_path).strip).to eq(expected_stream)
      end
    end
  end

  def terminal_table_stream(**options)
    Terminal::Table.new(options).to_s
  end

  def table_view_hash(**options)
    SmartStats::TableView.new(options).to_h
  end
end
