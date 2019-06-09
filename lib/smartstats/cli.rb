module SmartStats
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    desc 'version', 'Displays smartstats version'
    def version
      say VERSION
    end

    desc 'parse PATH', 'Parses .log file under PATH and generates some'\
         'useful stats'
    def parse(path)
      file   = SmartStats::FileLoader.new(path)
      visits = SmartStats::Visits.new
      lines  = file.readlines

      while (line = lines.pop)
        uri, ip = line.strip.split

        counter = SmartStats::IpCounter.new
        trace   = SmartStats::Trace.new(uri, counter)

        if (found = visits.find { |existing_trace| existing_trace == trace })
          found.track(ip)
        else
          trace.track(ip)
          visits << trace
        end
      end

      say Terminal::Table.new(table_view_hash(
        title: 'All Traces',
        rows: visits.all_traces
      ))

      say Terminal::Table.new(table_view_hash(
        title: 'Uniq Traces',
        rows: visits.uniq_traces
      ))
    rescue SmartStats::FileLoader::FileNotFoundError,
           SmartStats::FileLoader::FileExtError => err
      say err.message
    end

    private

    def table_view_hash(**options)
      Hash(SmartStats::TableView.new(options))
    end
  end
end
