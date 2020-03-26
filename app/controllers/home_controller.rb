class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = api.openweathermap.org/data/2.5/weather?id=6714466a75ef7842af9d373139741d1d
    #@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=89129&distance=0&API_KEY=96A38DFD-5C56-4740-AD99-E38C0C855A1B'
    @url = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)
  end
end
