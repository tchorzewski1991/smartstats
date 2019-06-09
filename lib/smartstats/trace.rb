module SmartStats
  class Trace
    attr_reader :route, :counter

    def initialize(route, counter)
      @route   = route
      @counter = counter
    end

    def track(key)
      counter.track(key)
    end

    def all_entries
      counter.all_entries
    end

    def uniq_entries
      counter.uniq_entries
    end

    def hash
      route.hash
    end

    def eql?(other)
      hash == other.hash
    end

    alias == eql?

    def <=>(other)
      route <=> other.route
    end

    def to_a(property = :all_entries)
      [route, send(property)]
    rescue NoMethodError => _err
      to_a
    end
  end
end
