module SmartStats
  class Visits < Set
    def initialize(*)
      super()
    end

    def all_traces
      collect_sorted(:all_entries)
    end

    def uniq_traces
      collect_sorted(:uniq_entries)
    end

    private

    def collect_sorted(property)
      sort.each_with_object([]) do |trace, result|
        result << trace.to_a(property)
      end
    end
  end
end
