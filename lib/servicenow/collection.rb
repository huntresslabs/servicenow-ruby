module ServiceNow
  class Collection
    attr_reader :total, :results

    delegate_missing_to :@results

    def initialize(response)
      @results = (response.body["result"] || []).map { |r| Result.new r }
      @total = response.headers["x-total-count"] || @results.size
    end
  end
end