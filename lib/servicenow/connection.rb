require "faraday"
require "faraday_middleware"

module ServiceNow
  class Connection
    delegate_missing_to :@connection

    def initialize(instance_id, token)
      @instance_id = instance_id
      @token = token

      @connection = Faraday::Connection.new(connection_options) do |conn|
        conn.use HttpErrors

        conn.authorization :Bearer, @token
        conn.request :json
        conn.response :json
        conn.adapter Faraday.default_adapter
      end
    end

    private

    def connection_options
      {
        url: "https://#{@instance_id}.service-now.com/api/now/"
      }
    end
  end
end