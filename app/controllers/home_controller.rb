class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = 'https://api.waqi.info/feed/Tokyo/?token=8abcce66dc3b4c006224da56f2ce53c660faccd4'
    #@url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=20002&distance=0&API_KEY=E3A54C9F-23E6-494A-979F-7B2FAA73AD5F'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    #Check the return is empty or not
    if @output.empty?
      @final_output = "ERROR"
    elsif !@output
      @final_output = "ERROR"
    else
      #@final_output = @output[0]['AQI']
      @final_output = @output["data"]["aqi"]
    end

    if @final_output == "ERROR"
      @api_color = "gray"
    elsif @final_output > 0 && @final_output<= 50
      @api_color = "green"
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
    end
    #Calling weather api of kathmandu
    @weather_url = 'http://api.openweathermap.org/data/2.5/weather?q=kathmandu&appid=6714466a75ef7842af9d373139741d1d'
    @weather_uri = URI(@weather_url)
    @weather_response = Net::HTTP.get(@weather_uri)
    @weather_output = JSON.parse(@weather_response)
    @weather_currenttemp = @weather_output["main"]["temp_max"]
    @weather_humidity = @weather_output["main"]["humidity"]
    @weather_wind = @weather_output["wind"]["speed"]
    @weather_pressure = @weather_output["main"]["pressure"]
    @weather_sunrise = @weather_output["sys"]["sunrise"]
    @weather_sunset = @weather_output["sys"]["sunset"]
    @weather_lon = @weather_output["coord"]["lon"]
    @weather_lat = @weather_output["coord"]["lat"]

    #Calling weather api of tokyo
    @weather_url_tokyo = 'http://api.openweathermap.org/data/2.5/weather?q=tokyo&appid=6714466a75ef7842af9d373139741d1d'
    @weather_uri_tokyo = URI(@weather_url_tokyo)
    @weather_response_tokyo = Net::HTTP.get(@weather_uri_tokyo)
    @weather_output_tokyo = JSON.parse(@weather_response_tokyo)
    @weather_currenttemp_tokyo = @weather_output_tokyo["main"]["temp_max"]
    @weather_humidity_tokyo = @weather_output_tokyo["main"]["humidity"]
    @weather_wind_tokyo = @weather_output_tokyo["wind"]["speed"]
    @weather_pressure_tokyo = @weather_output_tokyo["main"]["pressure"]
    @weather_sunrise_tokyo = @weather_output_tokyo["sys"]["sunrise"]
    @weather_sunset_tokyo = @weather_output_tokyo["sys"]["sunset"]
    @weather_lon_tokyo = @weather_output_tokyo["coord"]["lon"]
    @weather_lat_tokyo = @weather_output_tokyo["coord"]["lat"]
  end
end
