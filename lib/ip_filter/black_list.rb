module IpFilter

  class BlackList < List

    def approved?(remote_ip)
      !any?(remote_ip)
    end
  end
end
