RSpec.describe ServiceNow::Client do
  let(:instance_id)   { "instance_id_foo" }
  let(:client_id)     { "client_id_foo" }
  let(:client_secret) { "client_secret_foo" }
  let(:username)      { "some_user" }
  let(:password)      { "p4ssw0rd" }
  let(:refresh_token) { "refresh_token_foo" }
  let(:access_token)  { "access_token_foo" }

  let(:connection)    { double(Faraday) }
  let(:response)      { double(Faraday::Response, body: {"access_token" => access_token}) }

  describe ".authenticate" do
    it "connects" do
      expect(Faraday).to receive(:new).with({url: "https://#{instance_id}.service-now.com/"}).and_return(connection)
      expect(connection).to receive(:post).with("oauth_token.do",
        {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "password",
          username: username,
          password: password
        }
      ).and_return(response)

      client = described_class.authenticate(instance_id, client_id, client_secret, username, password)

      expect(client).to be_a(described_class)
      expect(client.connection).to be_a(ServiceNow::Connection)
      expect(client.connection.headers["Authorization"]).to eq("Bearer #{access_token}")
    end
  end

  describe ".authenticate_with_refresh_token" do
    it "connects" do
      expect(Faraday).to receive(:new).with({url: "https://#{instance_id}.service-now.com/"}).and_return(connection)
      expect(connection).to receive(:post).with("oauth_token.do",
        {
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "refresh_token",
          refresh_token: refresh_token,
          scope: "useraccount"
        }
      ).and_return(response)

      client = described_class.authenticate_with_refresh_token(instance_id, client_id, client_secret, refresh_token)

      expect(client).to be_a(described_class)
      expect(client.connection).to be_a(ServiceNow::Connection)
      expect(client.connection.headers["Authorization"]).to eq("Bearer #{access_token}")
    end
  end
end
