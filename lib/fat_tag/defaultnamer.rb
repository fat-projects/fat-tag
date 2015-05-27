module FatTag
  class DefaultNamer
    def set
      time.strftime("%Y%m%d-%H%M")
    end

    def time
      Time.now
    end
  end
end