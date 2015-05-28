require 'sinatra'
require 'sinatra/reloader'
require_relative '../../lib/fat_tag.rb'

configure :development do
  enable :reloader
end

get '/' do
  'Hello Fucking world'
end

post '/api/:commit_sha' do
  response = FatTag.post(params[:commit_sha], 'stintra-test')
  status 201
end

# Source Control
# Write Tests
# * Unit Test
# * Integrated Test