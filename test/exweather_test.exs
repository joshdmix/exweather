defmodule ExweatherTest do
  use ExUnit.Case
  alias Exweather.Request
  doctest Exweather

  @owm_url "api.openweathermap.org/data/2.5/weather?"

  test "url generated correctly" do
    assert Request.owm_url(11111) ==
    @owm_url <> "zip=11111&appid=#{System.get_env("OWM_API_KEY")}"
  end

end
