# frozen_string_literal: true

def auth_args
  [
    ENV["SNOW_INSTANCE_ID"],
    ENV["SNOW_CLIENT_ID"],
    ENV["SNOW_CLIENT_SECRET"],
    ENV["SNOW_USERNAME"],
    ENV["SNOW_PASSWORD"]
  ]
end

def oauth_stub_request
  body = {
    "access_token" => "access_token",
    "refresh_token" => "refresh_token",
    "scope" => "useraccount",
    "token_type" => "Bearer",
    "expires_in" => 1799
  }.to_json

  stub_request(:post, "https://instance_id.service-now.com/oauth_token.do")
    .with(
      body: { "client_id" => ENV["SNOW_CLIENT_ID"],
              "client_secret" => ENV["SNOW_CLIENT_SECRET"],
              "grant_type" => "password",
              "password" => ENV["SNOW_PASSWORD"],
              "username" => ENV["SNOW_USERNAME"] },
      headers: { "Accept" => "*/*" })
    .to_return(status: 200, body: body)
end

def users_stub_request
  body = {
    "result" => [
      { "sys_id" => "62826bf03710200044e0bfc8bcbe5df1",
        "user_name" => "abel.tuter" },
      { "sys_id" => "a8f98bb0eb32010045e1a5115206fe3a",
        "user_name" => "abraham.lincoln" }
    ]
  }.to_json

  stub_request(:get, "https://instance_id.service-now.com/api/now/table/sys_user?sysparm_fields=sys_id,user_name&sysparm_limit=2&sysparm_offset=0&sysparm_query=active=true%5EORDERBYuser_name")
    .with(headers: { "Accept" => "*/*",
                     "Authorization" => "Bearer access_token" })
    .to_return(status: 200, body: body)
end
