module ServiceNow
  module Configuration
    VALID_OPTIONS_KEYS = [
      :user_agent,
    ].freeze

    DEFAULT_USER_AGENT = "ServiceNow Ruby Gem #{ServiceNow::VERSION}".freeze

    # Define accessor methods for configuration keys
    attr_accessor *VALID_OPTIONS_KEYS

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    def reset
      self.debug = DEFAULT_DEBUG
      self.user_agent = DEFAULT_USER_AGENT
    end
  end
end