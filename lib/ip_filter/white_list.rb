module IpFilter

  class WhiteList < List

    def approved?(remote_ip)
      any?(remote_ip)
    end
  end
end
