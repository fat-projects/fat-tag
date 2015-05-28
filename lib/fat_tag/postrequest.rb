module FatTag
  class PostRequest
    attr_accessor :auth, :data, :path
    def initialize(auth = GithubAuth.new, args)
      @auth = auth
      @data = args[:data]
      @path = args[:path]
    end

    def call
      set_request_options
      request
    end
    
    private 

    def request
      @request ||= Net::HTTP::Post.new(path, {'Content-Type' =>'application/json'})
    end

    def set_request_options
      request.body = data.to_json
      request.basic_auth(auth.username, auth.password)
    end
  end
end
