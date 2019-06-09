module SmartStats
  class FileLoader < ::File
    FileNotFoundError = Class.new(StandardError)
    FileExtError      = Class.new(StandardError)

    ALLOWED_EXTENSIONS = %w(.log).freeze

    def initialize(path)
      super(check_file_path(path.to_s))
    end

    private

    def check_file_path(path)
      ensure_file_exists(path)
      ensure_file_ext(path)
      path
    end

    def ensure_file_exists(path)
      unless File.exist?(path)
        raise FileNotFoundError, "Err: File #{path} not found"
      end
    end

    def ensure_file_ext(path)
      unless ALLOWED_EXTENSIONS.include?(File.extname(path))
        raise FileExtError, "Err: File #{path} has unsupported extension"
      end
    end
  end
end
