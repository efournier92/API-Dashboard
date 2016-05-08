require "./lib/geolocation"
require "sinatra/base"
require "json"
require "pry"
require "net/http"

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base
  get "/" do
    @geolocation = Geolocation.new(@ip)
    @ip          = request.ip
    @time        = Time.now

    erb :dashboard
  end

  get "/weather" do
    key          = ENV["WUNDERGROUND_API_KEY"]
    uri          = URI("http://api.wunderground.com/api/#{key}/conditions/q/MA/Boston.json")
    response     = Net::HTTP.get_response(uri)
    @wunderjson  = JSON.parse(response.body)
    @temp        = @wunderjson["current_observation"]["temp_f"]
    @geolocation = Geolocation.new(@ip)

    erb :weather
  end

  get "/news" do
    key = ENV["NYTIMES_API_KEY"]
    uri = URI("http://api.nytimes.com/svc/topstories/v1/technology.json?api-key=#{key}")
    response = Net::HTTP.get_response(uri)
    @nytimes_json = JSON.parse(response.body)

    erb :news
  end

  get "/events" do
    uri = URI("https://api.seatgeek.com/2/events\?venue.city\=Boston\&datetime_utc.gte\=#{Date.today}\&datetime_utc.lte\=#{Date.today + 1}")
    response = Net::HTTP.get_response(uri)
    @events_json = JSON.parse(response.body)

    erb :events
  end
end
