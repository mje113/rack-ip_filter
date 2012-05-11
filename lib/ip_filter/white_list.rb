module IpFilter

  class WhiteList < List

    def approved?(remote_ip)
      @list.any? { |ip| ip.include?(remote_ip) }
    end
  end
end
