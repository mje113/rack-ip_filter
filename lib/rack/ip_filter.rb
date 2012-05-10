require 'netaddr'

module Rack

  class IpFilter

    VERSION = "0.0.1"

    def initialize(app, ip_whitelist, path)
      @app = app
      @ip_whitelist = ip_whitelist.map { |ip| NetAddr::CIDR.create(ip) }
      @path = path
    end

    def call(env)
      if white_listed?(env)
        @app.call(env)
      else
        forbidden!
      end
    end
    
    def white_listed?(env)
      return true unless env['REQUEST_PATH'] =~ /^#{@path}/

      remote_addr = remote_address(env)
      remote_addr == '127.0.0.1' || @ip_whitelist.any? { |ip_range| ip_range.contains?(remote_addr) }
    end

    def black_listed?(env)
      
    end

    def remote_address(env)
      if env['HTTP_X_FORWARDED_FOR']
        env['HTTP_X_FORWARDED_FOR'].split(',').first.strip
      else
        env['REMOTE_ADDR']
      end
    end

    def forbidden!
      [403, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]
    end

  end
end
