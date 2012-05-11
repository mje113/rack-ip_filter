module IpFilter

  class List

    def initialize(list)
      @list = Array(list).map { |ip| IPAddr.new(ip) }
    end
  end
end
