module ServiceNow
  class Client::Tables < Api
    def initialize(connection, table_name)
      super(connection)
      @table_name = table_name
    end

    def all(params = {})
      get_many "table/#{@table_name}", params
    end

    def find(id)
      get_one "table/#{@table_name}/#{id}"
    end

    def create(params = {})
      post "table/#{@table_name}", params
    end
  end
end