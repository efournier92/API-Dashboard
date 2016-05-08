require "./lib/geolocation"
require "sinatra/base"
require "json"
require "pry"
require "net/http"

require "dotenv"
Dotenv.load

class Weather < Sinatra::Base

  attr_reader :wunderground_key

  @wunderground_key = ENV["WUNDERGROUND_API_KEY"]

  get("/weather") do
    @ip = request.ip
    @geolocation = Geolocation.new(@ip)
    erb :weather
  end
end
