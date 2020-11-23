defmodule ExweatherTest do
  use ExUnit.Case
  alias Exweather.Request
  doctest Exweather

  @api_key System.get_env("OWM_API_KEY")
  @owm_url "pro.openweathermap.org/data/2.5/forecast/hourly?q="

  test "city, state url generated correctly" do
    assert Request.owm_url("City", "State") ==
             "#{@owm_url}City,State&appid=#{@api_key}"
  end

  test "city url generated correctly" do
    assert Request.owm_url("City") ==
             "#{@owm_url}City&appid=#{@api_key}"
  end
end
