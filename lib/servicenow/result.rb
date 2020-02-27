module ServiceNow
  class Result
    attr_reader :raw

    delegate_missing_to :@raw

    def initialize(result)
      @raw = result
    end

    def [](key)
      @raw[key.to_s]
    end
  end
end