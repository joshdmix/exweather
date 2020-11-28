defmodule Exweather.Request do
  require Logger

  @owm_url "api.openweathermap.org/data/2.5/weather?"
  # pro.openweathermap.org/data/2.5/forecast/hourly?q={city name}&appid={API key}

  # pro.openweathermap.org/data/2.5/forecast/hourly?q={city name},{state code}&appid={API key}

  def fetch(zip_code) do
    Logger.info("Zip code in fetch #{zip_code}")
    url = owm_url(zip_code)
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

  def owm_url(zip_code) do
    @owm_url <> "zip=#{zip_code}&appid=#{System.get_env("OWM_API_KEY")}"
  end
end
