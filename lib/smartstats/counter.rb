module SmartStats
  class Counter < Hash
    def initialize(*)
      super().tap do |counter|
        counter.default_proc = lambda do |hash, key|
          if (extracted = extract_key(key))
            hash[extracted] = 0
          end
        end
      end
    end

    def track(key)
      if (extracted = extract_key(key))
        self[extracted] += 1
      end
    end

    def all_entries
      entries.inject(0) { |sum, entry| sum + self[entry] }
    end

    def uniq_entries
      entries.count
    end

    alias entries keys

    private

    def extract_key(key)
      key
    end
  end
end
