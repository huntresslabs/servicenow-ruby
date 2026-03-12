RSpec.describe ServiceNow::Client do
  subject { ServiceNow::Client.authenticate(*auth_args) }

  let(:users) { subject.users.all(fields: "sys_id,user_name", query: "active=true^ORDERBYuser_name", offset: 0, limit: 2) }

  describe ".users" do
    before do
      oauth_stub_request
      users_stub_request
    end

    it "returns users" do
      expect(users).to be_a(ServiceNow::Collection)
      expect(users.first["sys_id"]).to eq("62826bf03710200044e0bfc8bcbe5df1")
      expect(users.first["user_name"]).to eq("abel.tuter")
      expect(users.last["sys_id"]).to eq("a8f98bb0eb32010045e1a5115206fe3a")
      expect(users.last["user_name"]).to eq("abraham.lincoln")
    end
  end
end
