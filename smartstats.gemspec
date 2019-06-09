lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartstats/version'

Gem::Specification.new do |spec|
  spec.name          = 'smartstats'
  spec.version       = SmartStats::VERSION
  spec.authors       = %w[tchorzewski1991]
  spec.email         = %w[tchorzewski.rafal@gmail.com]

  spec.summary       = %(Short summary)
  spec.description   = %(Short description)

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'pry', '~> 0.12.2'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rb-readline', '~> 0.5.5'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'

  spec.add_dependency 'terminal-table', '~> 1.8'
  spec.add_dependency 'thor', '~> 0.20'
end
