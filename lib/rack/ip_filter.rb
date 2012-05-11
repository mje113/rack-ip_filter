require 'ip_filter'

module Rack

  class IpFilter

    def initialize(app, list, path = '/')
      @app  = app
      @path = path
      @list = list
    end

    def call(env)
      if approved?(env)
        @app.call(env)
      else
        forbidden!
      end
    end

    def approved?(env)
      return true unless path_match?(env['REQUEST_PATH'])
      @list.approved?(remote_address(env))
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

    def path_match?(path)
      path =~ /^#{@path}/
    end

  end
end
