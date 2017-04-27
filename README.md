# Bluecat

This gem wraps certain operations with the Bluecat Address Management API via `savon`. I use this specifically to integrate with [Foreman](https://theforeman.org) so there is a lot that this gem cannot do, yet. That said, I am open to pull requests to add more features. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bluecat'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bluecat

## Usage

```ruby
require 'bluecat'
require 'pp'

client = Bluecat::Client.new(wsdl: 'https://hostname/Services/API?wsdl')
client.login('api-username', 'api-password')

# This is the object ID of where to start
# your search.
container_id = 1

pp client.ip4_networks(container_id).to_a

client.logout
```

It is a "best practice" (according to Bluecat's documentation) to logout at the end of a session. When I use this in other projects, I might expose it like so:

```ruby
class SomeUseCase
  # All access to API happens through this method
  def bluecat
    username = HammerCLI::Settings.get(:bluecat, :username)
    password = HammerCLI::Settings.get(:bluecat, :password)

    client = Bluecat::Client.new(wsdl: HammerCLI::Settings.get(:bluecat, :wsdl))
    client.login(username, password)

    yield client

    client.logout
  end
  
  def execute
    bluecat do |client|
      # Do things with the client
      client.ip4_networks(@container_id).take(10)
    end 
  end
end
```

In this way, the client will log in and out for every operation. This may not be best for your use-case.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mdwheele/bluecat.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

