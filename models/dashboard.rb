require "./models/geolocation"
require "sinatra/base"

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get("/") do
    @geolocation = Geolocation.new(@ip)
    erb :dashboard
  end
end
