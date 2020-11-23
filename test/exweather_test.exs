defmodule ExweatherTest do
  use ExUnit.Case
  alias Exweather.Request
  doctest Exweather
  @default_city "Louisville"
  @default_state "KY"
  @owm_url "pro.openweathermap.org/data/2.5/forecast/hourly?q="

  test "city, state url generated correctly" do
    assert Request.owm_url("City", "State") ==
             "#{@owm_url}City,State&appid=#{@api_key}"
  end

  test "city url generated correctly" do
    assert Request.owm_url("City") ==
             "#{@owm_url}City&appid=#{@api_key}"
  end

  test "default url generated correctly" do
  assert Request.owm_url() ==
      "#{@owm_url}#{@default_city},#{@default_state}&appid=#{@api_key}"
  end
end
