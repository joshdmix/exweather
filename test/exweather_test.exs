defmodule ExweatherTest do
  use ExUnit.Case
  alias Exweather.Request
  doctest Exweather
  @default_city "Louisville"
  @default_state "KY"
  @owm_url "pro.openweathermap.org/data/2.5/forecast/hourly?q="
  @api_key "127c1bcd8a39782d8f9dece152fff3a0"

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
