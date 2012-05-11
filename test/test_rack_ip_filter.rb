require 'helper'

class TestRackIpFilter < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def setup
    @range = '24.40.64.0/20'
    @local = '127.0.0.1'
    @good  = '24.40.64.23'
    @bad   = '9.9.9.9'
    @list  = [@range, @local]
  end

  def app
    Rack::IpFilter.new(lambda {|env| [200, {}, []] }, IpFilter::WhiteList.new(@list), '/')
  end

  def test_local_ip_address_admitted
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => @local }
    assert last_response.ok?
  end

  def test_allowed_remote_ip_address_admitted
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => @good }
    assert last_response.ok?
  end

  def test_outside_remote_ip_address_rejected
    get '/', {}, { 'REQUEST_PATH' => '/', 'REMOTE_ADDR' => @bad }
    assert !last_response.ok?
  end

  def test_local_ip_address_admitted_via_proxy
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [@local, @bad].join(', ') }
    assert last_response.ok?
  end

  def test_allowed_remote_ip_address_admitted_via_proxy
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [@good, @bad].join(', ') }
    assert last_response.ok?
  end

  def test_outside_remote_ip_address_rejected_via_proxy
    get '/', {}, { 'REQUEST_PATH' => '/', 'HTTP_X_FORWARDED_FOR' => [@bad, @good].join(', ') }
    assert !last_response.ok?
  end
  
end
