module IpFilter

  class BlackList < List

    def approved?(remote_ip)
      !@list.any? { |ip| ip.include?(remote_ip) }
    end
  end
end
