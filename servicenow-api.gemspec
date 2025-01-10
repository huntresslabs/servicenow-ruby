
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "servicenow/version"

Gem::Specification.new do |spec|
  spec.name          = "servicenow-api"
  spec.version       = ServiceNow::VERSION
  spec.authors       = ["Chris Bisnett"]
  spec.email         = ["cbisnett@gmail.com"]

  spec.summary       = "Ruby wrapper for the ServiceNow REST API"
  spec.description   = "Ruby wrapper for the ServiceNow REST API (formerly servicenow-ruby)"
  spec.homepage      = "https://github.com/huntresslabs/servicenow-ruby"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.16"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"

  spec.add_dependency "faraday", "< 2.0"
  spec.add_dependency "faraday_middleware", "< 2.0"
  spec.add_dependency "activesupport", ">= 5.0"
end
