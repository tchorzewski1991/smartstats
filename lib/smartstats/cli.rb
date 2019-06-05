require 'thor'

module SmartStats
  class CLI < Thor

    desc 'version', 'Displays smartstats version'
    map %w[-v --version] => :version
    def version
      say VERSION
    end
  end
end
