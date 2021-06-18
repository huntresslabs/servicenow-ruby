RSpec.describe ServiceNow::Api do
  subject { ServiceNow::Api.new(connection) }

  let(:connection) { ServiceNow::Connection.new(ENV["SNOW_INSTANCE_ID"], "access_token") }
  let(:params) { { fields: "sys_id,user_name", query: "active=true^ORDERBYuser_name", offset: 0, limit: 2 } }

  before do
    oauth_stub_request
    users_stub_request
  end

  describe "#prefix_params" do
    it "returns params prefixed with sysparm_" do
      expected = { sysparm_fields: "sys_id,user_name", sysparm_query: "active=true^ORDERBYuser_name", sysparm_offset: 0, sysparm_limit: 2 }
      expect(subject.prefix_params(params)).to eq(expected)
    end
  end

  describe "#get_* methods" do
    let(:methods) { %w[get_many get_one] }

    it "call prefix_params" do
      methods.each do |method|
        expect(subject).to receive(:prefix_params).with(params).and_call_original
        subject.send(method, "table/sys_user", params)
      end
    end
  end
end
