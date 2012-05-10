require 'minitest/autorun'
require 'rack/test'

class IpWhitelistTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  LOCAL_IP = '127.0.0.1'
  GOOD_IP  = '24.40.64.23'
  BAD_IP   = '9.9.9.9'

  def app
    Rack::IpFilter.new(lambda {|env| [200, {}, []] }, ['24.40.64.0/20'], '/')
  end

  test 'local ip address admitted' do
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => LOCAL_IP }
    assert last_response.ok?
  end

  test 'allowed remote ip address admitted' do
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => GOOD_IP }
    assert last_response.ok?
  end

  test 'outside remote ip address rejected' do
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => BAD_IP }
    assert !last_response.ok?
  end

  test 'local ip address admitted via proxy' do
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [LOCAL_IP, BAD_IP].join(', ') }
    assert last_response.ok?
  end

  test 'allowed remote ip address admitted via proxy' do
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [GOOD_IP, BAD_IP].join(', ') }
    assert last_response.ok?
  end

  test 'outside remote ip address rejected via proxy' do
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [BAD_IP, GOOD_IP].join(', ') }
    assert !last_response.ok?
  end
  
end
