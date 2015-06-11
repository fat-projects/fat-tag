module FatTag
  class ReleaseData
    attr_accessor :tagname, :target_commitish

    def initialize(namer = DefaultNamer.new, args)
      @tagname = namer.set
      @target_commitish = args[:target_commitish]
    end

    def self.call(args)
      new(args).call
    end 

    def call
      { 
        "tag_name" => tagname,
        "target_commitish" => target_commitish,
        "name" => tagname,
        "body" => "",
        "draft" => false,
        "prerelease" => false
      }
    end
  end
end
