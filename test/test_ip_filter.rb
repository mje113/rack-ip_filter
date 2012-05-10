require 'helper'

class IpWhitelistTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  LOCAL_IP = '127.0.0.1'
  GOOD_IP  = '24.40.64.23'
  BAD_IP   = '9.9.9.9'

  def app
    Rack::IpFilter.new(lambda {|env| [200, {}, []] }, ['24.40.64.0/20'], '/')
  end

  def test_local_ip_address_admitted
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => LOCAL_IP }
    assert last_response.ok?
  end

  def test_allowed_remote_ip_address_admitted
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => GOOD_IP }
    assert last_response.ok?
  end

  def test_outside_remote_ip_address_rejected
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => BAD_IP }
    assert !last_response.ok?
  end

  def test_local_ip_address_admitted_via_proxy
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [LOCAL_IP, BAD_IP].join(', ') }
    assert last_response.ok?
  end

  def test_allowed_remote_ip_address_admitted_via_proxy
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [GOOD_IP, BAD_IP].join(', ') }
    assert last_response.ok?
  end

  def test_outside_remote_ip_address_rejected_via_proxy
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [BAD_IP, GOOD_IP].join(', ') }
    assert !last_response.ok?
  end
  
end
