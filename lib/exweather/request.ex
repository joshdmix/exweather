defmodule Exweather.Request do
  require Logger

  @api_key System.get_env("OWM_API_KEY")
  @owm_url "pro.openweathermap.org/data/2.5/forecast/hourly?q="
  # pro.openweathermap.org/data/2.5/forecast/hourly?q={city name}&appid={API key}

  # pro.openweathermap.org/data/2.5/forecast/hourly?q={city name},{state code}&appid={API key}

  def fetch(url) do
    Logger.info("Fetching weather data...")
    HTTPoison.get(url)
    |> handle_response

  end

  def handle_response({:ok, %_{status_code: 200, body: body}}) do
    Logger.info("successful response")
    Logger.debug(fn -> inspect(body) end)
    {:ok, :jsx.decode(body)}
  end

  def handle_response({:ok, %_{status_code: status, body: body}}) do
    Logger.error("Error #{status} returned")
    {:error, :jsx.decode(body)}
  end

  def owm_url(city, state) do
    "#{@owm_url}#{city},#{state}&appid=#{@api_key}"
  end

  def owm_url(city) do
    "#{@owm_url}#{city}&appid=#{@api_key}"
  end
end
