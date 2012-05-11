require 'helper'

class TestWhiteList < MiniTest::Unit::TestCase

  def setup
    @range = '192.168.2.0/24'
    @included = '192.168.2.100'
    @not_included = '192.168.3.0'
  end

  def test_ip_approved
    list = IpFilter::WhiteList.new(@range)
    assert !list.approved?(@included)
  end

  def test_ip_restricted
    list = IpFilter::WhiteList.new(@range)
    assert list.approved?(@not_included)
  end

  def test_allows_arrays
    list = IpFilter::WhiteList.new([@range, @not_included])
    assert !list.approved?(@included)
  end
  
end
