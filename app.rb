require 'dotenv'
Dotenv.load

# gems
require 'sinatra'

# files
require_relative './lib/virgil.rb'

# controller
get '/' do
  Virgil.exist
  erb :index
end