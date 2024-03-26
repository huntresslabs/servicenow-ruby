module ServiceNow
  class Client
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    attr_reader :connection

    class << self
      def authenticate(instance_id, client_id, client_secret, username, password)
        authenticate_with_params(instance_id,
          grant_type: "password",
          client_id: client_id,
          client_secret: client_secret,
          username: username,
          password: password
        )
      end

      def authenticate_with_refresh_token(instance_id, client_id, client_secret, refresh_token)
        authenticate_with_params(instance_id,
          grant_type: "refresh_token",
          client_id: client_id,
          client_secret: client_secret,
          refresh_token: refresh_token,
          scope: "useraccount"
        )
      end

      private def authenticate_with_params(instance_id, params)
        connection_options = {
          url: "https://#{instance_id}.service-now.com/"
        }

        conn = Faraday.new(connection_options) do |faraday|
          faraday.request :url_encoded
          faraday.response :json
          faraday.response :raise_error
          faraday.adapter Faraday.default_adapter
        end

        response = conn.post('oauth_token.do', params)
        connection = Connection.new(instance_id, response.body["access_token"])
        Client.new(connection)
      end
    end

    def initialize(connection)
      @connection = connection
    end

    def incidents
      @incidents ||= Client::Tables.new(@connection, "incident")
    end

    def tables(table_name)
      Client::Tables.new(@connection, table_name)
    end

    def cmdb_instance(instance_class)
      Client::CMDB.new(@connection, instance_class)
    end
  end
end
