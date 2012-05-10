require 'netaddr'
require 'ip_filter'

module Rack

  class IpFilter

    def initialize(app, ip_whitelist, path)
      @app = app
      @ip_whitelist = ip_whitelist.map { |ip| NetAddr::CIDR.create(ip) }
      @path = path
    end

    def call(env)
      @env = env

      if white_listed?
        @app.call(env)
      else
        forbidden!
      end
    end
    
    def white_listed?
      return true unless env['REQUEST_PATH'] =~ /^#{@path}/ 
      
      remote_addr == '127.0.0.1' || @ip_whitelist.any? { |ip_range| ip_range.contains?(remote_addr) }
    end

    def black_listed?(env)
      
    end

    def remote_address
      remote_addr = begin
        if @env['HTTP_X_FORWARDED_FOR']
          @env['HTTP_X_FORWARDED_FOR'].split(',').first.strip
        else
          @env['REMOTE_ADDR']
        end
      end
    end

    def forbidden!
      [403, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]
    end

  end
end
