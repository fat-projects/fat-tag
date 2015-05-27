require './app/controllers/releases_controller'

set :root, File.dirname(__FILE__)

run Sinatra::Application
