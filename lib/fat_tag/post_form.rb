# Build a form
# Set URI
# Initialize http
# Enable https
# Initialize Post request
# Include user auth
# Set form as post body
# Make Reqest
# Log results

## Abstraction:
# Github Api Auth
# Post Form Data
# Separate the http setup from post form
# Namer

require "net/http"
require "uri"
require "json"
require 'yaml'

class HttpForm
  attr_accessor :request
  def initialize(args)
    @request = args[:request]
  end

  def self.call(args)
    new(args).call
  end

  def call
    set_http_options
    set_request_path

    response = http.request(request.call)
    puts response.body
  end

  def uri
    @uri ||= URI.parse("https://api.github.com/repos/jakef/stintra-test/releases")
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

  def request
    @request ||= Net::HTTP::Post.new(path, {'Content-Type' =>'application/json'})
  end

  def set_request_options
    request.body = data.to_json
    request.basic_auth(auth.username, auth.password)
  end
end

class DefaultNamer
  def set
    time.strftime("%Y%m%d-%H%M")
  end

  def time
    Time.now
  end
end

class GithubAuth
  def username
    config['basic']['username']
  end
  def password
    config['basic']['password']
  end

  def config
    YAML.load_file('github_auth.yml')
  end
end

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
      "body" => "You are not an idiot.",
      "draft" => false,
      "prerelease" => false
    }
  end
end

post_data = ReleaseData.call(target_commitish: "8cf066a60f9e4cb733a05da7fee3f34a4433a434")
post_request = PostRequest.new(data: post_data)
HttpForm.call(request: post_request)
