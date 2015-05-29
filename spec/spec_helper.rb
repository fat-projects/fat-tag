ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'webmock/minitest'
require 'rack/test'
include Rack::Test::Methods
require_relative '../lib/fat_tag.rb'
require_relative 'support/fake_github.rb'
require_relative '../app/controllers/releases_controller.rb'

# RSpec.configure do |config|
#   config.before(:each) do
    
#   end
# end

MiniTest::Spec.before do
  stub_request(:any, /api.github.com/).to_rack(FakeGitHub)
end

def app
  Sinatra::Application
end
