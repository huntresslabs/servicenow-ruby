module ServiceNow
  class Client::CMDB < Api
    def initialize(connection, instance_class)
      super(connection)
      @instance_class = instance_class
    end

    def all(params = {})
      get_many "cmdb/instance/#{@instance_class}", params
    end

    def find(id)
      get_one "cmdb/instance/#{@instance_class}/#{id}"
    end

    def create(params = {})
      post "cmdb/instance/#{@instance_class}", params
    end
  end
end