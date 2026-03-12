require "bundler/setup"
require "webmock/rspec"
require 'dotenv/load'

[["..", File::SEPARATOR, "lib"], ["support"]]
  .each { |args| Dir.glob(File.join(File.dirname(__FILE__), *args, "**"), &method(:require)) }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
