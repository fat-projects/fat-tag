require 'sinatra'
require 'sinatra/reloader'
require './lib/fat_tag'

configure :development do
  enable :reloader
end

get '/' do
  'Hello Fucking world'
end

post '/api/:commit_sha' do
  FatTag.post(params[:commit_sha], 'stintra-test')
end

post '/foo' do
  puts 'hello shitty app'
end

# 8cf066a60f9e4cb733a05da7fee3f34a4433a434
