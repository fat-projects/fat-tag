require 'sinatra'
require 'sinatra/reloader'
require_relative '../../lib/fat_tag.rb'

configure :development do
  enable :reloader
end

get '/' do
  'Hello Fucking world'
end

post '/:organization/:repo/:commit_sha' do
  response = FatTag.post(params[:organization], params[:repo], params[:commit_sha])
  puts response.body
end

# Source Control
# Write Tests
# * Unit Test
# * Integrated Test