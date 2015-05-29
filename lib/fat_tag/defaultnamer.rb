module FatTag
  class DefaultNamer
    def set
      time.strftime("%Y%m%d-%H%M")
    end

    private

    def time
      Time.now
    end
  end
end
