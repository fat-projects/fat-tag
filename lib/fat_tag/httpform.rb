module FatTag
  class HttpForm
    attr_accessor :request, :organization, :repo

    def initialize(args)
      @request = args[:request]
      @organization = args[:organization]
      @repo = args[:repo]
    end

    def self.call(args)
      new(args).call
    end

    def call
      set_http_options
      set_request_path

      response = http.request(request.call)
      response
    end

    private

    def uri
      @uri ||= URI.parse("https://api.github.com/repos/#{organization}/#{repo}/releases")
    end

    def http
      @http ||= Net::HTTP.new(uri.host, uri.port)
    end

    def set_request_path
      request.path = uri.path
    end

    def set_http_options
      http.use_ssl = true
    end
  end
end
