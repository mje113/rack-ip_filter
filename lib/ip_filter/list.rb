module IpFilter

  class List
    def initialize(*list)
      @list = list.flatten.map { |ip| IPAddr.new(ip) }
    end

    def any?(remote_ip)
      @list.any? { |ip| ip.include?(remote_ip) }
    end
  end
end
