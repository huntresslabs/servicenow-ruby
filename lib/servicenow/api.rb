module ServiceNow
  class Api
    attr_reader :connection

    def initialize(connection)
      @connection = connection
    end

    def get_many(path, params = {})
      ServiceNow::Collection.new connection.get(path, params)
    end

    def get_one(path, params = {})
      ServiceNow::Response.new connection.get(path, params)
    end

    def post(path, params = {})
      ServiceNow::Response.new connection.post(path, params)
    end

    def patch(path, params = {})
      ServiceNow::Response.new connection.patch(path, params)
    end

    def put(path, params = {})
      ServiceNow::Response.new connection.put(path, params)
    end

    def delete(path)
      connection.delete(path)
    end
  end
end