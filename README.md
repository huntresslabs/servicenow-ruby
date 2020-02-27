# ServiceNow

The ServiceNow Ruby library provides convenient access to the [ServiceNow](https://developer.servicenow.com/app.do#!/document/content/app_store_doc_rest_integrate_newyork_c_RESTAPI?v=newyork) REST API. The library is structured such that it can be used to manage multiple ServiceNow tenants.

*Note: Not all API endpoints are implemented and more continue to be added as time permits.*

## Documentation

API documentation:
- [REST Basics](https://developer.servicenow.com/app.do#!/document/content/app_store_doc_rest_integrate_newyork_c_RESTAPI?v=newyork)
- [REST API Reference](https://docs.servicenow.com/bundle/newyork-application-development/page/build/applications/concept/api-rest.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'servicenow-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install servicenow-ruby

## Usage

To create a client for a ServiceNow instance using OAuth:

```ruby
client = ServiceNow.authenticate(
    "myhost.service-now.com",
    "client_id",
    "client_secret",
    "username",
    "password"
)

# get all incidents
client.incidents.all()
```

API methods are organized in the client based on the record type. For example, methods for creating/modifying/deleting incidents can be accessed through the `incidents` namespace:

```ruby
# get all incidents
client.incidents.all()

# create a new incident
client.incidents.create(
    short_description: "My First Incident",
    description: "This incident is the best incident because..."
)
```

### Table Access

Any table can be accessed using the `tables()` method of the client. Simply specify the table name and you can interact with the table through the ServiceNow Tables API methods.

```ruby
# get a reference to the table
mytable = client.tables("my_table")

# get all the table rows
mytable.all()
```

### Filtering, Sorting, Paging

Not yet implemented.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Run all tests:

    bundle exec rake spec

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/huntresslabs/servicenow-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the servicenow-ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/huntresslabs/servicenow-ruby/blob/master/CODE_OF_CONDUCT.md).
