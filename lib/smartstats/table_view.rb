module SmartStats
  class TableView
    DEFAULTS = {
      title: 'Results',
      headings: %w[Uri Hits],
      rows: [],
      style: { all_separators: true },
    }.freeze

    attr_reader :title, :headings, :rows, :style

    def initialize(options = {})
      options.to_h.tap do |opts|
        @title    = opts.delete(:title)    || DEFAULTS[:title]
        @headings = opts.delete(:headings) || DEFAULTS[:headings]
        @rows     = opts.delete(:rows)     || DEFAULTS[:rows]
        @style    = DEFAULTS[:style].merge(opts.delete(:style) || {})
      end
    end

    def to_hash
      { title: title, headings: headings, rows: rows, style: style }
    end

    alias to_h to_hash
  end
end
