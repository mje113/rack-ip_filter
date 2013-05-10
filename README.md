# Rack::IpFilter

A Rack middleware component which does simple White and Black list filtering of remote IP Adresses.

Provides support for CIDR notation for ranges as well as specific addresses.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-ip_filter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-ip_filter

## Usage

First require:

    require 'rack/ip_filter'

For Rails, you can insert the middleware in your `config/application.rb`:

    IP_WHITELIST = %w(192.168.2.0/24 127.0.0.1)

    module YourApp
      class Application < Rails::Application
        config.middleware.use Rack::IpFilter, IpFilter::WhiteList.new(::IP_WHITELIST)
      end
    end

See example/app.rb for a simple Sinatra app which illustrates proper usage. 

## Options

`Rack::IpFilter` takes two arguments, the first is an object that responds to `approved?` and returns a boolean.
The second argument is the path to apply the filter, defaults to root: `'/'`.

`IpFilter::WhiteList` and `IpFilter::BlackList` ship with the gem and explicitly allow or block remote ip addresses
respectively.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
