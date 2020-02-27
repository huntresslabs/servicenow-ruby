module ServiceNow
  class Response
    attr_reader :result

    delegate_missing_to :@result

    def initialize(response)
      @result = Result.new(response.body["result"])
    end
  end
end