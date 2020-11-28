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
    formatted_body = format_body(:jsx.decode(body))
    Logger.info(inspect(formatted_body))
    {:ok, formatted_body}
  end

  def handle_response({:ok, %_{status_code: status, body: body}}) do
    Logger.error("Error #{status} returned")
    {:error, :jsx.decode(body)}
  end

  def owm_url(zip_code) do
    @owm_url <> "zip=#{zip_code}&appid=#{System.get_env("OWM_API_KEY")}"
  end

  def format_body(body) do
    body_map = Enum.into(body, %{})
    main = body_map |> Map.get("main") |> Enum.into(%{})
    coord = body_map["coord"] |> Enum.into(%{})

    %{
      city: body_map["name"],
      lat: coord["lat"],
      lon: coord["lon"],
      max: main["temp_max"],
      min: main["temp_min"],
      temp: main["temp"],
      feels_like: main["feels_like"],
      pressure: main["pressure"],
      humidity: main["humidity"]
    }
  end
end
