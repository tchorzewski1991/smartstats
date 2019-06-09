module SmartStats
  class IpCounter < Counter
    private

    def extract_key(value)
      value.to_s[/\b(?:\d{1,3}\.){3}\d{1,3}\b/]
    end
  end
end
