require 'sinatra/base'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'rack/ip_filter'

# rackup -s thin app.rb
# http://localhost:9292/test
class App < Sinatra::Base

  use Rack::IpFilter, IpFilter::WhiteList.new('192.168.2.0/24', '127.0.0.1'), '/'
  use Rack::IpFilter, IpFilter::WhiteList.new('127.0.0.1'), '/admin'
  use Rack::IpFilter, IpFilter::BlackList.new('192.168.2.23'), '/'

  set :root, File.dirname(__FILE__)

  get '/test' do
    content_type "text/plain"
    body "Hello world!"
  end

end
