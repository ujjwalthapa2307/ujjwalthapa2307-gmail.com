class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    @url = 'http://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=20002&distance=0&API_KEY=E3A54C9F-23E6-494A-979F-7B2FAA73AD5F'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    #Check the return is empty or not
    if @output.empty?
      @final_output = "ERROR"
    elsif !@output
      @final_output = "ERROR"
    else
      @final_output = @output[0]['AQI']
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
    #Calling weather api
    @weather_url = 'http://api.openweathermap.org/data/2.5/weather?q=London&appid=6714466a75ef7842af9d373139741d1d'
    @weather_uri = URI(@weather_url)
    @weather_response = Net::HTTP.get(@weather_uri)
    @weather_output = JSON.parse(@weather_response)
  end
end
