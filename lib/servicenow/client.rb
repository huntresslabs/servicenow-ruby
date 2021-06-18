module ServiceNow
  class Client
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    attr_reader :connection

    class << self
      def authenticate(instance_id, client_id, client_secret, username, password)
        connection_options = {
          url: "https://#{instance_id}.service-now.com/"
        }

        conn = Faraday.new(connection_options) do |faraday|
          faraday.request :url_encoded
          faraday.response :json
          faraday.response :raise_error
          faraday.adapter Faraday.default_adapter
        end

        params = {
          grant_type: "password",
          client_id: client_id,
          client_secret: client_secret,
          username: username,
          password: password
        }

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

    def users
      @users ||= Client::Tables.new(@connection, "sys_user")
    end

    def tables(table_name)
      Client::Tables.new(@connection, table_name)
    end

    def cmdb_instance(instance_class)
      Client::CMDB.new(@connection, instance_class)
    end
  end
end